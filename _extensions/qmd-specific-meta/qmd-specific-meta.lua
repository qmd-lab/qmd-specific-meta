
quarto.log.output("==== From Quarto Log ====")

function Meta(el)
  quarto.log.output("input", quarto.doc.input_file)
  quarto.log.output("offset", quarto.project.directory)
  for _,doc in ipairs(el["qmd-specific-meta"]) do
    quarto.log.output(doc.href)
    if doc.href[1].text == "example1.qmd" then
      quarto.log.output(doc.href)
      doc.href = nil
      for k,v in pairs(doc) do
        doc.k = nil
        el[k] = nil
        el[k] = v
        --quarto.log.output(">>>", el[k])
      end
    end
  end

  --quarto.log.output(el)
  return el

end
