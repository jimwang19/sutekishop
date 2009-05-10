﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/CmsSubMenu.master" Inherits="Suteki.Shop.ViewPage<CmsViewData>" %>
<%@ Import Namespace="MvcContrib"%>
<%@ Import Namespace="Suteki.Common.Repositories"%>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

<h1><%= Model.Menu.Name%></h1>
<div class="message"><%= TempData["message"] %></div>
<p>
    <%= Html.ActionLink<CmsController>(c => c.Add(Model.Menu.ContentId), "New Page")%>&nbsp;
    <%= Html.ActionLink<MenuController>(c => c.New(Model.Menu.ContentId), "New Menu")%>
</p>

<%= Html.Grid(Model.Menu.Contents.InOrder()).Columns(column => {
		column.For(x => x.Type).Named("&nbsp;").HeaderAttributes(@class => "thin");
		column.For(x => x.Link(Html)).DoNotEncode().Named("&nbsp;").HeaderAttributes(@class => "thin");
		column.For(x => x.EditLink(Html)).DoNotEncode().Named("&nbsp;").HeaderAttributes(@class => "thin");
		column.For(x => Html.Tick(x.IsActive)).DoNotEncode().Named("&nbsp;").HeaderAttributes(@class => "thin");
		column.For("&nbsp;").Partial("UpDown").HeaderAttributes(@class => "thin"); //Re-ordering arrows
		column.For(x => x.IsMenu ? Html.ActionLink<CmsController>(c => c.Add(x.ContentId), "New Page") : "&nbsp;").DoNotEncode().Named("&nbsp;").HeaderAttributes(@class => "thin");
		column.For(x => x.IsMenu ? Html.ActionLink<MenuController>(c => c.New(x.ContentId), "New Menu") : "&nbsp;").DoNotEncode().Named("&nbsp;").HeaderAttributes(@class => "thin");
			
	}) %>


</asp:Content>
