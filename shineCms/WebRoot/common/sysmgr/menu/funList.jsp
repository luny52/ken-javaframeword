<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/path.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>权限功能管理</title>
<link rel="stylesheet" href="${path}r/css/base.css"/>
<link title="${themes}" rel="stylesheet" href="${path}r/operamasks-ui/css/${themes}/om-${themes}.css">
<link title="${themes}" rel="stylesheet" href="${path}r/css/themes/${themes}/style.css"/>
<script type="text/javascript" src="${path}r/js/jquery.min.js"></script>
<script type="text/javascript" src="${path}r/operamasks-ui/js/operamasks-ui.min.js"></script>
<script type="text/javascript" src="${path}r/js/shine.js"></script>
<script type="text/javascript">
var grid,editDialog;
//保存成功后回调
function saveSuccess(){
	closeEditDialog();
	refreshData();
}
//关闭编辑框
function closeEditDialog(){
	if(editDialog.omDialog('isOpen')){
		editDialog.omDialog('close');
	}
}
//刷新grid数据
function refreshData(){
	grid.omGrid('reload');
}
//打开编辑框
function toEdit(funId){
	editDialog = $.shine.openDialog({id:"editDialog", title:"编辑功能", url:"${path}sysmgr/fun_toEdit.do?e.funId="+funId, width:600, height:400});
}
//删除记录
function toDelete(ids){
	if(confirm("确认删除所选记录？")){
		$.post('${path}sysmgr/fun_delete.do','id='+ids,function(data){
	        $.shine.listAjaxBack(data,grid);
	    });
    }
}
$(document).ready(function() {
	$('#btn_add').omButton({
		icons : {left : '${path}r/css/themes/${themes}/image/icon/add.gif'},
		onClick : function(){
			editDialog = $.shine.openDialog({id:"editDialog", title:"增加功能", url:"${path}sysmgr/fun_toAdd.do?e.menuId=${menuId}", width:600, height:400});
		}
	});
	$('#btn_modify').omButton({
		icons : {left : '${path}r/css/themes/${themes}/image/icon/modify.gif'},
		onClick : function(){
			var selections=grid.omGrid('getSelections',true);
            var len = selections.length;
            if (len == 0) {
            	alert('请选择要修改的记录');
                return false;
            }
            if(len >1 ){
            	alert('一次只能修改一条记录');
                return false;
            }
            var id = selections[0].funId;
            toEdit(id);
		}
	});
	$('#btn_delete').omButton({
		icons : {left : '${path}r/css/themes/${themes}/image/icon/delete.gif'},
		onClick : function(){
			var selections=grid.omGrid('getSelections',true);
            var len = selections.length;
            if (len == 0) {
            	alert('请至少选择一行记录');
                return false;
            }
            //将选择的记录的id传递到后台去并执行delete操作
            var ids = '';
            for(var i=0;i<len;i++){
            	ids += selections[i].funId + ',';
            }
            ids = ids.substr(0,ids.length-1);
            toDelete(ids);
		}
	});
    grid = $.shine.omGrid({
    	id : 'grid',
        dataSource : '${path}sysmgr/fun_list.do?menuId=${menuId}',
        singleSelect : false,
        colModel : [ 
        			 {header : 'Key', name : 'funKey', width : 100, align : 'left'}, 
                     {header : '名称', name : 'funName', width:120, align : 'left'},
                     {header : '操作', name : 'funId', width:100, align : 'center',renderer:function(value,rowData,rowIndex){
                    	 return "<a href='javascript:void(0);' onclick='toEdit(\""+value+"\");' title='修改'><img src='${path}r/css/themes/${themes}/image/icon/modify.gif' border='0' align='absmiddle' alt='修改'/></a>" +
                    	 "&nbsp;<a href='javascript:void(0);' onclick='toDelete(\""+value+"\");' title='删除'><img src='${path}r/css/themes/${themes}/image/icon/delete.gif' border='0' align='absmiddle' alt='删除'/></a>";
                     }}
                   ]
    });
});
</script>
</head>
<body class="list">
<div class="toolbar mar">
	<a href="javascript:void(0);" id="btn_add">新增</a>
	<a href="javascript:void(0);" id="btn_modify">修改</a>
	<a href="javascript:void(0);" id="btn_delete">删除</a>
    <span style="margin-left: 50px;color:blue;">菜单：${parent.menuName}</span>
</div>
<table id="grid"></table>
</body>
</html>