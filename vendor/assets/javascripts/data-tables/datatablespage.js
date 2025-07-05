//= require data-tables/datatables.min
//= require data-tables/datatables.bootstrap4.min

function initializeDataTable(css) {
  $('.' + css).DataTable({
    aLengthMenu: [
      [25, 50, 100, -1],
      [25, 50, 100, 'All']
    ],
    iDisplayLength: 25,
    language: {
      search: "Search"
    },
    dom: '<"row"<"col-sm-12 col-md-3"l><"#datatable-extra-toolbar.col-sm-12 col-md-5"><"col-sm-12 col-md-4"f>><"row"<"col-12"t>><"row"<"col-sm-12 col-md-6"i><"col-sm-12 col-md-6"p>>'
  });

  $('.' + css).removeClass(css)
}
