Return-Path: <virtio-dev-return-13987-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B5FE81E19
	for <virtio-dev@archiver.kernel.org>; Fri,  6 Oct 2023 16:17:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1F9E745B2B
	for <virtio-dev@archiver.kernel.org>; Fri,  6 Oct 2023 16:17:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 14CAE98682E
	for <virtio-dev@archiver.kernel.org>; Fri,  6 Oct 2023 16:17:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0637E986820; Fri,  6 Oct 2023 16:17:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6E7298681C;
	Fri,  6 Oct 2023 16:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1696609022.869000
X-TM-MAIL-UUID: f10f70f2-4149-4fef-a8bd-89586a911767
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+ybTtsb3Xri67brZaiOZOizFXKHvAvsbj5pLWyPzb/sK/oE4CvuXu8/7hIkqhURVm3X8IdUnVpprY/hrN0oRBmzqAiInGsCeB2zpqhMWpusYJr1ZkekYfwSpSeHzYsERXOQAj1DqZ7bX2eUEeNJG8PPeYnoDuhUESNLwDmM12tS2SNvq61E4RGwDv4GX3YSpz+pEgd3hXmLwkZf5PT7/Fpt+XL5WGYJx2ypuZGvw9D2GbogO7O96crZHBjw1a7vqNHeNd65nDAPhQ25rt6Z8H4SOpn+qBBzAibIYpeEoiXRgigU99jbKoy2oPnpa5aguxR3/0tOIOpiLsWyG7Ljlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBDcfoR2cCm0ECKPQmzBZWvx+yARHlVbmmhNnqdaHnk=;
 b=DdAOCqjTvkjLhzabD0B+NmLkSNkOoIIi4+NDyXFDuUOGmOijSXt6oZ2Ynb207dcdT+fBcHhp7pJeSZYjoeoaRRnolIx+MmiM81XLjQWUzINCacV7j+lIMzjikfMXXPSiJtuJGE5v6ib6KaGrwUbyLdi2EpWPR1h2QKiJhi75rLBZdYiuLdgjKXqwhrIEqxDsYEO4I/YoXm/PYqwJ4oiwhvlUUA0QOU8djNc7BzLKRB9foFtxUyLCUaFhOA5eAiOdAD882Mh/z5QhAmS9u/3Yb8Q5wgRXWMmohq8Kq7U9n1Ri3NZHtehQ4WZfXuNWJunOh7w3lZldeuGoVLQhJJzhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <0c514678-d71f-4d73-bb43-b30fde320a27@opensynergy.com>
Date: Fri, 6 Oct 2023 18:17:17 +0200
Content-Language: en-US
To: Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
 luiz.dentz@gmail.com, mst@redhat.com, marcel@holtmann.org,
 johan.hedberg@gmail.com, jasowang@redhat.com,
 Hao Chen <chenhaosjtuacm@google.com>, Sal Savage <salsavage@google.com>
References: <20230310062613.109867-1-Igor.Skalkin@opensynergy.com>
 <20230310062613.109867-2-Igor.Skalkin@opensynergy.com>
 <CAPR809u5AehjXzjn4QcsVUybL=pW9mWGDJHXfcXRZCXvTcEiLw@mail.gmail.com>
From: Igor Skalkin <igor.skalkin@opensynergy.com>
In-Reply-To: <CAPR809u5AehjXzjn4QcsVUybL=pW9mWGDJHXfcXRZCXvTcEiLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To BEZP281MB3157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3157:EE_|FR3P281MB2236:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca988e3-57fe-4293-b845-08dbc687ac0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TkiG+8DFN7greDBa74y8eLzZwg1tWBWUDUxyh1Pm00XpCY2yljOXi368Nv+XPTZBM6D+rmIpD3zev62rTAGB3xlmfFQlC2L2a7Gf5NLsmpf8xUBXCyDxlC8nM5ErOlh3j3UGSMUeRqpusho43xQsiluDcFlWPIIzFoUPe1g61dPSvEPvhIHFx9wOeGheujSuS5+paaBaVU2mS/WYNWlo0kK6AyTh+5+SGStExVQBroYh7wbaHw+TbCBT+OriXtA/nKCpTMlH1I2H25f1pIXU4cwKeOi1NH3hgOt2dTtJaxXLVL56J+niH72GkIVUlYhiMFTakk/8eBSws1h/om0NJWo9QUxQK/+iN3XN60X4zSYjLGjeoSYJPmU5sWwYgTKgHAosfrAtxzUMewCrnmKrR7BTpsjd+HWc6rLA7u4lBPgBAWQOH+SRzcSbrXFYlkbfcSiNpboI1pfXu24fVhxLUZQLlqV8K9GwqZnoQBcbxOj1kbeHfPl3RXfuj5dlsntSUY8l4jahxe3WoN3++fa4ALzevAE3uL3LufcFwqKqmYMKZ2egJSjfgsWwV8Etz1ezIG39VKb2DU/dr0RasixIKA4Pa49rrmjgvBsXNMwtz2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3157.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39840400004)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(7416002)(31686004)(44832011)(4326008)(8936002)(8676002)(5660300002)(30864003)(2906002)(38100700002)(41300700001)(316002)(6916009)(42186006)(54906003)(2616005)(26005)(66899024)(66476007)(66946007)(66556008)(478600001)(31696002)(53546011)(86362001)(36756003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1p1MndEUUNoSHJvQ05BUzdmYWdGbCtndTZ1cytZSXAwYnNhaWN6MkY2T2xm?=
 =?utf-8?B?Tm5Ua3VEZE0wUjJxblhFTUk5UDJGbVdRL1daT3oxMW9mUWpaNmdVNWpIYTU5?=
 =?utf-8?B?cktWWUcvQ0l1S0xoRUNRK1RGTGFsZzR4TEh0UDNodDVTdmpzaEZvMFpJbG9J?=
 =?utf-8?B?eEtBVGJ1SnBpbHVtRy9YaEQzYnZBVjMwRGhhZkxnOGJtTzlsdGVoRGJJQ1JK?=
 =?utf-8?B?eEJZTlNIaGRvbCtyd1o0VWtOVVVpeXBIZCtMRmZ3cmJTbllTRHpFTHRRd3RQ?=
 =?utf-8?B?MDFEQXZ4Q2cySzN4cUtjekV2TkFsSkJQcDNMTUp5UzRoMjBPVytHQ0prY3BN?=
 =?utf-8?B?UDFWbHJhVkI4a2hOcHNjODRQc0Y4eXhuK01YekdoY0Z5TDNKY1lYMzF4anl1?=
 =?utf-8?B?QjM4MXlETmVGbGVJOTZGQUlQSkUrNFhLMVdjTExsa0MwYjE2TENNUTlCSzF6?=
 =?utf-8?B?L253T05sZmdBOWZEaHhyQTZNN1YrMHl2NlIyOUVzOGNWOHc3SmFCV0puR3d1?=
 =?utf-8?B?aDB2MEJKcWJXZjFzZ0liYmpnTXVwc0xtWHI4VE9sY21Ydk1UdXF5bnVobWN3?=
 =?utf-8?B?SERGZk1yMnhGbVlmMnAwV0tqQ3htS2VhOVJJbHdRNk9qWE1PbC9oenVmNXBK?=
 =?utf-8?B?bGdxM0xZL2JuVVJOQzB1NFVxK1VLcGdaZ3RGMDhGcGVaaHRJSU9LVE4rSWh3?=
 =?utf-8?B?czBzOVZQbDRaYzFkb2M4eDg4MUVpSkpMQndadTJxVVJ2dVpBZGVSU1hWdHIv?=
 =?utf-8?B?blR4alRhVXNnNk82aTVsaE9SMkhmN1N0Sy9zVUhQU1AzZnlNNUdCYklvWFJI?=
 =?utf-8?B?UzVtNjBFclF1TUtMbU5ZQmppUVdsdE1qdm8vUEZ2Q2JkS1ZnSVQ3a05LK2Rn?=
 =?utf-8?B?SCszeVpNTE42U0hBUC9JM3cxTnV4Rlg2dE5BV1NDaDk1dWRYQmoxczMzYjFl?=
 =?utf-8?B?bmRhZzhsa2FmRlFwVE9VSmZUWjRjdVNVTG1NZXpGNUJVZGNXMUxVWC9ncUhT?=
 =?utf-8?B?VmsxVUZ0WXBSUUNBdjZPdGVrbUZjcHNDVkZKYWFsYitDUXlhMFVtVkViTngy?=
 =?utf-8?B?THVSMklxeW1sbWdROXpVbXNsbDJGZlg2MFNmN1hJRHcyMUpmL0t2NkxCdWkr?=
 =?utf-8?B?bGsrNDNySVQwbEJydzBwSjhybU4wcGFybEpnOXVMV3hZYjgrOHhCYlpoeTlH?=
 =?utf-8?B?ZjJvVnAwYmlUQi9LbFd5UEFZeUNTckpXc3Q2Uk04NS9QbGhwOHEyL2xhYkdF?=
 =?utf-8?B?Uk0wM1A5V3ppcWJ3U2hsK1RtL2tTVEJkbTVWdk1EVGV2MEVyZ3Btd2JSb2cy?=
 =?utf-8?B?eDZkUytiK21JdzF4Z1FiWnFaRFZpTXlVaHd3TFlWdTY3cnBNQTBNWHZEekgv?=
 =?utf-8?B?bllsS2JFcmhtbGt5NG1kN3JvUlVyMW1JUE10Sy9BaG5TVFNhZ0U2KzB0NGlw?=
 =?utf-8?B?cUdyZTAxWkVqaVJtSFFGMEd6VmFlRlRIVlh2c1I5cENYNzVOeXJhVHZveWd0?=
 =?utf-8?B?YW9kZ0RRNTRVcFVSZnAzdWJGdGlweGF3TWpQTGU1RzYxdk16ODhLM3lEZko2?=
 =?utf-8?B?ZGMwWXEvTmZMODBUek81QTVPcjhidzRIZ0RHWDNFa2FHK3RqZW5YajZ4MmdX?=
 =?utf-8?B?RmFmejhtZGQ2ZTZKWGR0dUtkZHdyUjZ3M25YQU9yclB0NzZqK2J1L1NyRXNr?=
 =?utf-8?B?RFI1bUxvNTFqYmhhWVlYY3BGMTZXbDFzYXZKdzRBd0ttejRxa2RZcVlBNTMv?=
 =?utf-8?B?cU5hK2ltMFIrWjd3cmNzTzNnWDRjODBlbEVQenZ0ZHNrMG5RYW1aUHkyWExi?=
 =?utf-8?B?eFZod1NHRW85WjVnR0RKOFZhZ2w0N3NNNnJMSnNmTS9WWENPRklkRmx6VVhx?=
 =?utf-8?B?N3c2K3FhbzkrTnVteHNLb1ZtWC9OaXhvbU1wYnJYTnNyMlNrczNjQndKVUwy?=
 =?utf-8?B?N3RtRWU1WjcxVzEwUDNoQXl5QzFIUFAvcnVEQXhWKytrVzU0YnE4LzArQjlB?=
 =?utf-8?B?S21MYlFGbFRYQmIvdjhLSHNneWx3eDlkRm4vUStoTGpMbG8wRk02WVVkelFi?=
 =?utf-8?B?aEFxYUFkc09OMEFreUR6MmRaRERRUW8wMW96MzF6TG5hYzFpbWp2Umg5QlBs?=
 =?utf-8?Q?lTdxya9gdPhJpBeT3ji26nTaX?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca988e3-57fe-4293-b845-08dbc687ac0d
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3157.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 16:17:01.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIZkE1oz0QhjFENYc1S4W6ed2g7ndplKVBwhreM5tX+IV6EhRdPNoFV7okPxXHutbULquRVo911ZKEi/SYdLVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2236
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27920.000
X-TMASE-Result: 10--35.150700-4.000000
X-TMASE-MatchedRID: CxmI61mtwh/5ETspAEX/non73EnA6dC3AH+xhFp7E0R83mXuKlGTiM80
	ePfi+8z9dUYlcySF7KeBKiDPq08OQsZHwxLpmDPhu/wZEqxodZYKfUYWORZ3hbdQknz6f/hFODZ
	lhXUN3XWUVkUQf589ZxBM+f8NEYY4ncgHVDE4JqvPEeDcxvUDjMngJstbsoC51McWg5VNQo8YBM
	zz3cgh19moJDKaV79JeXJXJj1uXPK0FwM6kYXI1lZB3ebKuqDZN0X64jGy2dapaB8gxaWhLLgAq
	6sLXqe6Ir/i04LJ5SvutOqlmhRwLwRADDTxusaksjKXwoAhxb/cHWFKCmADc4vmY1hE2VDU+3DG
	ARmE5RAeFzrg+xNuermAt1c2rBY8rddi2w4fb9Ds+7E98/tcIHKa5XrXQyxS1V1wEPpYvg+HMYC
	9kIQAFltzIOiRIwELhU3SHT8rOPtlf38Z0pSQ61o/1P3BDpl/X9IqjVqUsLihUVgvBwisdinSIU
	gKVwzaKrSui2WP+XagNjRpi+9xy8GZlIhcRMmQ7yR/hLt1y2iUiGLkY8AZ4ze8kfZmKg2trgdeA
	A2yA+ohsuitEcCrFEaj20VUrpT7m5NwnYNFEjsn3oRlBssjXHSk8VaCrUo2utQM5jga8o5e9lbU
	N3myksnl8iynZhELylozWYipf9sQP61cTTVQFfe+18RAuG2TlZroRtOiCG3/C1BBkjM4dkfd+cH
	Ep3N3vnHi8YbTNkd4rCWGPtw61Gh636Fc0o9vCzp4ZDpFqX0VJPUqXnrQdaIcpU3/gcCMFuq4UF
	iMsTpWs61KweL/rBPvf+2VkMIRPLD4sNzZECLFTQGAKRxj5No+48giqZwn6eHzLh/npgivngkjH
	jojpAP5R/zL3aImJpK4F9wnIiaQZS2ujCtcuA==
X-TMASE-XGENCLOUD: 2030c533-8932-4ebe-971b-2a24377ab1e5-0-0-200-0
X-TM-Deliver-Signature: 65C1843CA062A85DE135C4E56ED67CD7
X-TM-Addin-Auth: x29JDgnrt7ZTiIRuunByUzcOQutPv4k27R1pfuEIYxY+fzp5SQJlohD2xf1
	vRl459+TSwMItSplmcfTcFK8AqSnDG1QnRfvKjos+bdkbGLWYT7TpCTR+NGJflKaehRRBAcmKIf
	8QjcE7rcBu5wsoviogb5NIJf+hzOe6crcm8B+L/JjRplwRV9NvG3DgfkzRlBA/XncexGWuU8nUU
	PHqxHaEFokhSoiohn1qRDoR+/WLwusoyQY/qDgRBCmZH9fulXhRDDSU/LA0aN2NEguEXETnPx2+
	0PqflLRjYy4wf9I=.oegQ82fcoNSnVz08cLt9zK0EF8btwEhtCxr8W/KMrMxN0TOPTBBBudUoCq
	JWfrWb1XeO/0nKi7cbkmhGwN/o5eTzo5k4bkQZgfKO0SisU/BbUu/npKJBYg5lcynRFdnoRNnnl
	Kfc8BHdpys8/67+0GY+OKR4rCzGd0mliOWAkcNEsZTZVQBxKJB5Unl1VyitDZOXYibsrsI+x4DD
	Kn8GkONFN6MNa0XaRKnY8KR/gkpFH8HVWyyXrVWW4IXcD8/bcnT8PPEJMlpY/ytymfII0OL0L1T
	mi7hBsYwRxunYD/yHrTXwXkLe/HuA1TOYqLL/8lrcFQAaXKtma6ULotAIUg==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] [PATCH 1/1] RFC: virtio-bt: add virtio BT device
 specification

Hello all, sorry for a delay.

Almost all of you questions relate to the structure of the configuration 
space, in which I simple described the current virtio-bt driver 
implementation in the Linux kernel.

Brief history of this draft specification:
   - Suddenly the virtio-bt Linux kernel driver was merged in the mainline.
   - We started using it in our projects - for this we wrote a host 
virtio Bluetooth device.
   - This device could not be merged because the structure of the 
configuration space is not aligned, which violates the virtio 
specification (and our virtio MMIO middle layer asserts such accesses).
   - The corrected version of the configuration with the corresponding 
feature bit was also merged into the mainline.
   - But fixing the configuration requires fixing the specification.
   - There is no specification - that means someone need to write it.
   - Well, for the first draft version I think it is possible to simply 
describe the existing Linux implementation and see what can be done with 
all this.
   - we are here.

The main question is whether there are already existing devices that use 
this configuration structure.
I do not know, may be the authors of the Linux kernel driver know the 
answer to this question, and they are in this message CC.

About the use of the second version of the configuration by new devices 
- can, should or must they use it. It seems to me that they must, since 
the old one violates the virtio specification.
[q]
4.2.2.2 Driver Requirements: MMIO Device Register Layout
...
For the device-specific configuration space, the driver MUST use 8 bit 
wide accesses for 8 bit wide fields, 16 bit wide and aligned accesses 
for 16 bit wide fields and 32 bit wide and aligned accesses for 32 and 
64 bit wide fields.
[/q]

On 3/22/23 00:24, Enrico Granata wrote:
> On Thu, Mar 9, 2023 at 11:27 PM Igor Skalkin
> <Igor.Skalkin@opensynergy.com> wrote:
>>
>> This PR is aimed as review for comments(RFC) purpose.
>>
>> * Initial draft version.
>>
>> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
>> ---
>>   conformance.tex                        |  12 ++-
>>   content.tex                            |   1 +
>>   device-types/bt/description.tex        | 112 +++++++++++++++++++++++++
>>   device-types/bt/device-conformance.tex |   8 ++
>>   device-types/bt/driver-conformance.tex |   8 ++
>>   5 files changed, 137 insertions(+), 4 deletions(-)
>>   create mode 100644 device-types/bt/description.tex
>>   create mode 100644 device-types/bt/device-conformance.tex
>>   create mode 100644 device-types/bt/driver-conformance.tex
>>
>> diff --git a/conformance.tex b/conformance.tex
>> index 01ccd69..a69eb47 100644
>> --- a/conformance.tex
>> +++ b/conformance.tex
>> @@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
>>   \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
>>   \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
>> -\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
>> -\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
>> +\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
>> +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
>> +\ref{sec:Conformance / Driver Conformance / BT Driver Conformance}
>>
>>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>>     \end{itemize}
>> @@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
>>   \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
>>   \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
>> -\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
>> -\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
>> +\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
>> +\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
>> +\ref{sec:Conformance / Device Conformance / BT Device Conformance}
>>
>>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>>     \end{itemize}
>> @@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \input{device-types/scmi/driver-conformance.tex}
>>   \input{device-types/gpio/driver-conformance.tex}
>>   \input{device-types/pmem/driver-conformance.tex}
>> +\input{device-types/bt/driver-conformance.tex}
>>
>>   \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
>>
>> @@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \input{device-types/scmi/device-conformance.tex}
>>   \input{device-types/gpio/device-conformance.tex}
>>   \input{device-types/pmem/device-conformance.tex}
>> +\input{device-types/bt/device-conformance.tex}
>>
>>   \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
>>   A conformant implementation MUST be either transitional or
>> diff --git a/content.tex b/content.tex
>> index 0c7cdf8..3723ec8 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -3022,6 +3022,7 @@ \chapter{Device Types}\label{sec:Device Types}
>>   \input{device-types/scmi/description.tex}
>>   \input{device-types/gpio/description.tex}
>>   \input{device-types/pmem/description.tex}
>> +\input{device-types/bt/description.tex}
>>
>>   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>
>> diff --git a/device-types/bt/description.tex b/device-types/bt/description.tex
>> new file mode 100644
>> index 0000000..3ce265d
>> --- /dev/null
>> +++ b/device-types/bt/description.tex
>> @@ -0,0 +1,112 @@
>> +\section{BT Device}\label{sec:Device Types / BT Device}
>> +
>> +The virtio-bt device provides an HCI (Host Control Interface) over VirtIO
>> +link between the guest HCI device and the host HCI backend.
>> +Also, the device can inform the guest driver which vendor-specific command
>> +set it supports.
>> +Host Control Interface is described in Bluetooth Core Specification:
>> +\newline\url{https://www.bluetooth.com/specifications/specs/core-specification-5-4/}\\
> 
> Are you giving any thought to out of band communication (e.g. A2DP and HFP)?
> 
A2DP works on top of HCI, with HFP everything is more complicated.
There is already a working project with the transmission of additional 
commands to the host to control the switching of audio streams on host.
But, it was necessary, because BT chip on board in this project do not 
support SCO over HCI, but has hardware connection to PCM.
In common case (BT USB dongle, for example) SCO data should be 
transmitted via HCI connection.
A project with the transmission of SCO data via HCI will be started 
soon, that is, work is underway but has not yet reached the 
specification phase.
>> +
>> +\subsection{Device ID}\label{sec:Device Types / BT Device / Device ID}
>> +
>> +40
>> +
>> +\subsection{Virtqueues}\label{sec:Device Types / BT Device / Virtqueues}
>> +
>> +\begin{description}
>> +\item[0] transmitq
>> +\item[1] receiveq
>> +\end{description}
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / BT Device / Feature bits}
>> +
>> +\begin{description}
>> +\item[VIRTIO_BT_F_VND_HCI (0)]  Indicates vendor command support.
>> +\item[VIRTIO_BT_F_MSFT_EXT (1)] Indicates MSFT vendor support.
>> +\item[VIRTIO_BT_F_AOSP_EXT (2)] Indicates AOSP vendor support.
>> +\item[VIRTIO_BT_F_CONFIG_V2 (3)] The device uses the second version of the
>> +configuration space structure.
>> +\end{description}
>> +
> 
> How are these different from the vendor fields discussed elsewhere in the spec?
> Is it the idea that any vendor could support AOSP or MSFT specific
> command sets, and so you need two separate flags?
> 
> If so, maybe calling them "guest OS support" instead of "vendor" might
> be a better choice to avoid confusion
> Also, we should probably document somewhere what commands those
> extensions entail
> 
Thank you, will be fixed in next version.

>> +\devicenormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
>> +
>> +The device MUST require the driver to accept the VIRTIO_BT_F_CONFIG_V2 feature
>> +bit, i.e. not set FEATURES_OK without it, and use the second version
>> +(struct virtio_bt_config_v2) of the configuration layout, because the
>> +first one (struct virtio_bt_config) is unaligned, which violates the
>> +specification.
>> +
>> +The device should offer VIRTIO_BT_F_MSFT_EXT or VIRTIO_BT_F_AOSP_EXT feature bit
>> +if it supports correspondingly MSFT or AOSP extension command sets. In case of
>> +VIRTIO_BT_F_MSFT_EXT, device should also set configuration \field{msft_opcode}.
>> +
>> +The device should offer VIRTIO_BT_F_VND_HCI feature bit and set \field{vendor}
>> +to the VIRTIO_BT_CONFIG_VENDOR_ZEPHYR, VIRTIO_BT_CONFIG_VENDOR_INTEL or
>> +VIRTIO_BT_CONFIG_VENDOR_REALTEK, if it supports corresponding vendor extensions.
>> +
>> +\drivernormative{\subsubsection}{Feature bits}{Device Types / BT Device / Feature bits}
>> +
>> +The driver MUST accept VIRTIO_BT_F_CONFIG_V2 feature bit if offered by the device.
>> +
>> +The driver SHOULD accept any of the  VIRTIO_BT_F_VND_HCI, VIRTIO_BT_F_MSFT_EXT
>> +or VIRTIO_BT_F_AOSP_EXT feature bits if offered by the device.
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / BT Device / Device configuration layout}
>> +
>> +
>> +The first version:
>> +\begin{lstlisting}
>> +struct virtio_bt_config {
>> +       u8 type;
>> +       le16 vendor;
>> +       le16 msft_opcode;
>> +} __attribute__((packed));
>> +\end{lstlisting}
>> +
>> +is deprecated, new devices must use the second one:
>> +\begin{lstlisting}
>> +struct virtio_bt_config_v2 {
>> +       u8 type;
>> +       u8 alignment;
>> +       le16 vendor;
>> +       le16 msft_opcode;
>> +};
>> +\end{lstlisting}
>> +
>> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / BT Device / Device configuration layout}
>> +The device MUST NOT present a value different than
>> +\begin{lstlisting}
>> +       VIRTIO_BT_CONFIG_TYPE_PRIMARY = 0,
>> +       VIRTIO_BT_CONFIG_TYPE_AMP = 1,
>> +\end{lstlisting}
>> +in \field{type}.
> 
> What do these values mean?
> 
Bluetooth controllers can be one of two types - HCI_PRIMARY or HCI_AMP 
(Alternate MAC/PHY (AMP) secondary controllers).
The description can be found in the Bluetooth Core Specification up to 
version 4.2; starting from version 4.3, HCI_AMP was removed from the 
specification due to the fact that no one uses it.
Also, this field is not used at all in the current version of the Linux 
kernel driver. So maybe, this field should be marked unused in the 
specification.
>> +
>> +The values 1..3 of the \field{vendor} are already reserved for vendor extensions listed below:
>> +\begin{lstlisting}
>> +       VIRTIO_BT_CONFIG_VENDOR_NONE = 0
>> +       VIRTIO_BT_CONFIG_VENDOR_ZEPHYR = 1
>> +       VIRTIO_BT_CONFIG_VENDOR_INTEL = 2
>> +       VIRTIO_BT_CONFIG_VENDOR_REALTEK = 3
>> +\end{lstlisting}
>> +
> 
> How would any other vendor add their extensions to this list?
> For example, say I start my own Bluetooth adapter company tomorrow,
> how do I add VENDOR_ENRICO to the list?
> 
Please, do not do that))
Sorry, I actually don't know the answer to this question.
But there is one idea, it is necessary to consult the driver author:

differences between specific vendors include:
a) During setup, the command "Read build info/version" with vendor 
specific opcode is executed and does nothing with the result.
b) The set_bdaddr() function is replaced using a non-standard opcode.
c) The vendor-specific set of the HCI_QUIRK_* bits in the hdev->quirks 
field is set.

So, to make the configuration more flexible, it is possible to remove 
the "vendor" field and add some new configuration fields:

а) opcode for set_bdaddr command (if non-standard)
b) opcode for "Read Build Information"/"Read Version"
c) HCI_QUIRK_* bit mask which necessary to be set to hdev->quirks.

>> +If value of the \field{vendor} is not VIRTIO_BT_CONFIG_VENDOR_NONE, device MUST
>> +offer VIRTIO_BT_F_VND_HCI feature bit.
>> +
>> +\drivernormative{\subsubsection}{Driver configuration layout}{Device Types / BT Device / Driver configuration layout}
>> +All configuration fields are read-only for the driver.
>> +
>> +\subsection{Device initialization}\label{sec:Device Types / BT Device / Device initialization}
>> +
>> +The virtqueues are initialized.
>> +
>> +\subsection{Device operations}\label{sec:Device Types / BT Device / Device operations}
>> +
>> +The driver SHOULD populate the receive queue with at least one buffer of at
>> +least 258 bytes to contain 1 byte "packet type" and HCI event packet (2 bytes
>> +of HCI event packet header and up to 255 bytes payload).
>> +Synchronous and asynchronous data packets that are longer than the provided
>> +buffer will be fragmented.
>> +
>> +The driver sends to the transmit queue all (command and data) packets, received
>> +from the guest HCI device, and transfers to the guest HCI device all (event and
>> +data) HCI packets, received from the receive queue.
>> diff --git a/device-types/bt/device-conformance.tex b/device-types/bt/device-conformance.tex
>> new file mode 100644
>> index 0000000..7b73f4a
>> --- /dev/null
>> +++ b/device-types/bt/device-conformance.tex
>> @@ -0,0 +1,8 @@
>> +\conformance{\subsection}{Bluetooth Device Conformance}\label{sec:Conformance / Device Conformance / Bluetooth Device Conformance}
>> +
>> +A BT device MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{devicenormative:Device Types / BT Device / Feature bits}
>> +\item \ref{devicenormative:Device Types / BT Device / Device configuration layout}
>> +\end{itemize}
>> diff --git a/device-types/bt/driver-conformance.tex b/device-types/bt/driver-conformance.tex
>> new file mode 100644
>> index 0000000..2264a79
>> --- /dev/null
>> +++ b/device-types/bt/driver-conformance.tex
>> @@ -0,0 +1,8 @@
>> +\conformance{\subsection}{BT Driver Conformance}\label{sec:Conformance / Driver Conformance / BT Driver Conformance}
>> +
>> +A BT driver MUST conform to the following normative statements:
>> +
>> +\begin{itemize}
>> +\item \ref{drivernormative:Device Types / BT Device / Feature bits}
>> +\item \ref{drivernormative:Device Types / BT Device / Driver configuration layout}
>> +\end{itemize}
>> --
>> 2.37.2
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

