require 'spec_helper'

RSpec.describe Fcoin::Endpoint::Accounts do
  let(:client) { Fcoin::Client.new }
  
  describe '#accounts_balance' do
    let(:response) { client.accounts_balance }
    let(:body)     { JSON.parse(response.body) }

    context 'when client is authorized', fcoin_auth: true, vcr: { cassette_name: 'accounts/balance_auth', record: :new_episodes } do
      it 'response data should be got' do
        expect(body['data']).to eq [{"currency"=>"maya", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"gene", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"fres", "category"=>"gpm", "available"=>"60.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"60.000000000000000000"},
                                    {"currency"=>"oas", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"tos", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"wte", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"zil", "category"=>"gpm", "available"=>"34.104656029395267656", "frozen"=>"0.000000000000000000", "balance"=>"34.104656029395267656"},
                                    {"currency"=>"omg", "category"=>"innovation", "available"=>"0.220459671644954039", "frozen"=>"0.000000000000000000", "balance"=>"0.220459671644954039"},
                                    {"currency"=>"icx", "category"=>"gpm", "available"=>"1.522982867743779579", "frozen"=>"0.000000000000000000", "balance"=>"1.522982867743779579"},
                                    {"currency"=>"btm", "category"=>"innovation", "available"=>"3.918842444121259336", "frozen"=>"0.000000000000000000", "balance"=>"3.918842444121259336"},
                                    {"currency"=>"ae", "category"=>"gpm", "available"=>"0.027787771125676705", "frozen"=>"0.000000000000000000", "balance"=>"0.027787771125676705"},
                                    {"currency"=>"dagt", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"zrx", "category"=>"innovation", "available"=>"0.027426476746268948", "frozen"=>"0.000000000000000000", "balance"=>"0.027426476746268948"},
                                    {"currency"=>"fota", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"xrp", "category"=>"main", "available"=>"0.043566063515862241", "frozen"=>"0.000000000000000000", "balance"=>"0.043566063515862241"},
                                    {"currency"=>"fbc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"bnb", "category"=>"innovation", "available"=>"0.038305939165145111", "frozen"=>"0.000000000000000000", "balance"=>"0.038305939165145111"},
                                    {"currency"=>"iic", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"gtc", "category"=>"gpm", "available"=>"0.000000007538065563", "frozen"=>"0.000000000000000000", "balance"=>"0.000000007538065563"},
                                    {"currency"=>"ges", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"vns", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"jac", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"zsc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"but", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"cofi", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"scl", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"fi", "category"=>"innovation", "available"=>"0.009046890230133252", "frozen"=>"1378.620000000000000000", "balance"=>"1378.629046890230133252"},
                                    {"currency"=>"baic", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"bcv", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"mot", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"wicc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"vlc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"fbee", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"icc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"dht", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"fff", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"mesh", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ink", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ruff", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"fuel", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"latx", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"777", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"msc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"cps", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"dta", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"mof", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"beauty", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"edu", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"dscoin", "category"=>"gpm", "available"=>"10.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"10.000000000000000000"},
                                    {"currency"=>"musk", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"smt", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"dpn", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"see", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ccc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"sac", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"aidoc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"18t", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"boc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"hotc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"xps", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"lmm", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"rte", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"rnt", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"vpp", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"pnt", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"idxe", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"mxm", "category"=>"gpm", "available"=>"8.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"8.000000000000000000"},
                                    {"currency"=>"newos", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"tst", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"mdt", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"sss", "category"=>"gpm", "available"=>"9.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"9.000000000000000000"},
                                    {"currency"=>"dcc", "category"=>"gpm", "available"=>"2650.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"2650.000000000000000000"},
                                    {"currency"=>"pra", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"banca", "category"=>"gpm", "available"=>"6.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"6.000000000000000000"},
                                    {"currency"=>"cccx", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"dscb", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"gus", "category"=>"gpm", "available"=>"2.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"2.000000000000000000"},
                                    {"currency"=>"pmd", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"yee", "category"=>"gpm", "available"=>"6.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"6.000000000000000000"},
                                    {"currency"=>"dag", "category"=>"gpm", "available"=>"1.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"1.000000000000000000"},
                                    {"currency"=>"let", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"datx", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ocn", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"blz", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"soc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"at", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ngot", "category"=>"gpm", "available"=>"1.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"1.000000000000000000"},
                                    {"currency"=>"dws", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"tct", "category"=>"gpm", "available"=>"1.830000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"1.830000000000000000"},
                                    {"currency"=>"3db", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"lxt", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"sgcc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"hpc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ifood", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"tbcoin", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"gram", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"arp", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ait", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"nc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"aaa", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"cbr", "category"=>"gpm", "available"=>"6.660000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"6.660000000000000000"},
                                    {"currency"=>"sda", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"brm", "category"=>"gpm", "available"=>"0.005000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.005000000000000000"},
                                    {"currency"=>"fair", "category"=>"gpm", "available"=>"10.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"10.000000000000000000"},
                                    {"currency"=>"ees", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"cit", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"rct", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"xmx", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ionc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"drct", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"drink", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"iht", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ejoy", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"iov", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"mst", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"lovc", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"sec", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"btc", "category"=>"main", "available"=>"0.000156995481988083", "frozen"=>"0.000000000000000000", "balance"=>"0.000156995481988083"},
                                    {"currency"=>"eth", "category"=>"main", "available"=>"0.001177659105993741", "frozen"=>"0.000000000000000000", "balance"=>"0.001177659105993741"},
                                    {"currency"=>"pai", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"bch", "category"=>"main", "available"=>"0.000919246371553010", "frozen"=>"0.000000000000000000", "balance"=>"0.000919246371553010"},
                                    {"currency"=>"show", "category"=>"gpm", "available"=>"600.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"600.000000000000000000"},
                                    {"currency"=>"ltc", "category"=>"main", "available"=>"0.001735178376909046", "frozen"=>"0.000000000000000000", "balance"=>"0.001735178376909046"},
                                    {"currency"=>"biz", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"usdt", "category"=>"main", "available"=>"1.542208102053158021", "frozen"=>"0.000000000000000000", "balance"=>"1.542208102053158021"},
                                    {"currency"=>"vct", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"tkt", "category"=>"gpm", "available"=>"0.000000000000000000", "frozen"=>"0.000000000000000000", "balance"=>"0.000000000000000000"},
                                    {"currency"=>"ft", "category"=>"innovation", "available"=>"20.671877714849728410", "frozen"=>"0.000000000000000000", "balance"=>"20.671877714849728410"},
                                    {"currency"=>"zip", "category"=>"innovation", "available"=>"3918.597034485853214932", "frozen"=>"10000.000000000000000000", "balance"=>"13918.597034485853214932"},
                                    {"currency"=>"etc", "category"=>"main", "available"=>"0.382569624756478966", "frozen"=>"0.000000000000000000", "balance"=>"0.382569624756478966"}]
        expect(body['status']).to eq 0
      end

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end

    context 'when client is not authorized', vcr: { cassette_name: 'accounts/balance_not_auth', record: :new_episodes } do
      it 'should return error message' do
        expect(body['msg']).to eq "api key check fail : {\"status\":1020,\"msg\":\"api key not found : Fcoin API Public Key\"}"
        expect(body['status']).to  eq 6005
      end

      it 'response status code is 200' do
        expect(response.status).to eq 200
      end
    end
  end
end