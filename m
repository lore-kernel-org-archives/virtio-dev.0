Return-Path: <virtio-dev-return-12274-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EF6C77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 09:51:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2A5AC29FCF
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 09:51:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B56E9863E8
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 09:51:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E75A6984043; Tue, 18 Apr 2023 09:51:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3E4B9863E3
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Apr 2023 09:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1681811460.212000
X-TM-MAIL-UUID: 8e2a42c2-f2a4-4d8f-b0d3-14cb9322d518
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJQ5W5R7sG4qvngqK/XRAYHhdDaMTKNv0jUXMDxofCujX6E4yuNyDmDekeQ9MelIJqLXssDP0yqkg/xPuVFzvfWulWSI1+FTbM2puThd4JVK4tjilcmDXUNCvwc6cMlmew4OOURhzjjk+7xPdJZE/5NhaoE9rV6YYhCX1A1VHQFADxDJ8BA4jeWUgxeFd5EmzyWlCuGcj55YjK82TDgYyiEYQdXX+OwX7LmXmjms8z3qjtPIBfbIVxZl+WObgfnHLulsmqihEpquolIqxcdmFmV6W9z4a6TQlGgQ3BwCMzOcb+5pK5UN1eF6sWcf1cQ4FcQc9ZcX1hBiiZGwe1UCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq/DrkI6mAt5UT22sxBbIujmVrLT0K/fZtqIUId3C44=;
 b=clCgfQn+TWk0u/Xmcnn71js10dQJZ9UtFsQ1IQ0lF7Fj100RMfCqnLZpJqbLnYEPUfWoIYR9OMrEOXHcs8s11rgmtiScCUMpYSL0gPW22aASlTUqIKQtzp1mT+r4sLsSjWgAMTw8/Gy90GVJsWt1UP8UvONPWXUiGXu1wjFuj8O/2q3KUle+xnD7tzq8TtjwpxmWvsxFs8Xb2X6IqtyTcRxm36wsh7tqkQ2vMAoLaZ7n+RIl4z8Dq/WBaYR2+hOA9c/d9FtkN3VV9IjCi0EqnPUBdCcNUcRjmKKLZ0kxK/04szNfr88idRPnKqE6snGZ+GJ2Sq6UNRqDDe7fTI/FjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <9786872e-1063-e1ff-dc0d-6be5952a1826@opensynergy.com>
Date: Tue, 18 Apr 2023 11:50:56 +0200
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Harald Mommer <harald.mommer@opensynergy.com>,
 virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
 stratos-dev@op-lists.linaro.org, Matti Moell <Matti.Moell@opensynergy.com>
References: <20220825134449.18803-1-harald.mommer@opensynergy.com>
 <20220827093909.ag3zi7k525k4zuqq@pengutronix.de>
 <40e3d678-b840-e780-c1da-367000724f69@opensynergy.com>
 <c2c0ba34-2985-21ea-0809-b96a3aa5e401@siemens.com>
 <36bb910c-4874-409b-ac71-d141cd1d8ecb@app.fastmail.com>
 <c20ee6cf-2aae-25ef-e97f-0e7fc3f9c5b6@opensynergy.com>
 <20230414-scariness-disrupt-5ec9cc82b20c-mkl@pengutronix.de>
Content-Language: en-US
From: Harald Mommer <hmo@opensynergy.com>
In-Reply-To: <20230414-scariness-disrupt-5ec9cc82b20c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::13) To FR2P281MB1608.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:8b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR2P281MB1608:EE_|BE1P281MB2888:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c66dce-76ce-4f6a-6a64-08db3ff2692f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c4bUo2iyS6CqYIhVOyltIGnHGhxnwG8Tbx6LJsg4x5HPnPcV3XlU8ZMBjTb+gRf7zWG/8NN4h23Nvd2FxjIqey29Sk6E0tge8m+mBf1hpU+EBOyyA1rtJpPw1f83Lg73XxUuUiqP6VWiQFed7MEYVpFrFQpg8S/4KGPDFmWMcBzaQfcbs62Khtkbs/S3dAo+92Bb7BRvmDsuOGpavs85KiPH0JmF0RFrBXNveFwdb7ih7PgaSURRtq7vdmwGkLHlAAZ0MbJFUbqQvwKQuOgU5RnpBuSWYNm+L1QWyY5lUCr17LZ83d/GLADp0Qo1YjzDeipA4kghEHLVVvAN3TFxuNiTSp/2m2tvilBHwLMEBJERlaVIg/GAXh8gqboiqzRIwRZ88486ngHHzg0kGu6ThnQTxmlYOzsxBbVFmk7u0ZhrJZj6jSuczCqcEqeeT5+0gB1+3lFcGmSaw+YHWV1Ye/YNm0htcsmuP7M9PPGfULKyYgIO6DwN5ZZXCNbGXIW4VcBcGPc/Gl9/fkLAaZQj6u9YSRYBxxugW1g3VETe+NhEacHSmEOEvNowjYIcHHWR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB1608.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(39840400004)(376002)(451199021)(7416002)(5660300002)(2616005)(107886003)(31696002)(6636002)(83380400001)(186003)(53546011)(26005)(38100700002)(8676002)(8936002)(478600001)(54906003)(42186006)(110136005)(316002)(41300700001)(36756003)(66476007)(66556008)(4326008)(66946007)(31686004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2pKcXZsMWdZVGVSbjRJQll0UWNnVFpNQ3VlT1J1RFh3L1VFOVVLQmlYa3ZG?=
 =?utf-8?B?cDNZRkV2NThvaXFmTVN5aEszTEZ1SjZwcFNBSm5tQS8zaUtIZzRPeHYyUUpP?=
 =?utf-8?B?eDlqWUFoT0wxRGF6eWN4cXU3VGtHNkNyaGtXQi9SQnFiWnNqcGRpTEUxbmJQ?=
 =?utf-8?B?N2I1RkUrRi9ta0NmMkJxNDdteWtVV1BDU3JIbzZ6bUZxdHExd1VwNU41MEFz?=
 =?utf-8?B?dVNEbk1CVnhONndsMnRRQmcyTGNXaEVYRGpnOTdvOHRpZnAweTV2Yms2MDND?=
 =?utf-8?B?eWc0Yk5pbEF5VFFBWnhtbnUySnZENWxJampDUlg2dlFGK3V3YjQzaTg0YU1h?=
 =?utf-8?B?aTNBV1Vmc3Rtb0k5dmRyZTZOSDl2WUVaYUs0a1RreFpBL2toNkEyc21Fb0Q2?=
 =?utf-8?B?SkJvWTVvS21SclR6VWl0QWlhejdac3d2dG9zalJXSHlwMFdxbVFGaDhZeHRm?=
 =?utf-8?B?QXh1NWRob1VBUmlVelRjempSQXhtVGZ3L3daRGh3YXE0R0I3MjNPcnpaWnlW?=
 =?utf-8?B?dHdJZnVlNXBpK0JvYjFJQmtxSUJrVHUrell1NTNodCtsL09FSDNDZnRYODIz?=
 =?utf-8?B?UFE1ekczZlVLVllSVklVOFEwY09IZ3hsb1JUZ3ViWXoybU5tWEY5b3NoUkhn?=
 =?utf-8?B?OHY3SCtOWXZjcUYxUGtuTTBHSGtMSUx3T2VQRGRzM3pUMEJWV2FaZi9nTlk1?=
 =?utf-8?B?N0hSY09VWVUzTFlieENBRFA0dmZadUFnZGpJeFdBYVNUejViTk1RQ2xvZlRn?=
 =?utf-8?B?VkxsaGhWWmlKMWFSbDZIZjRkQkcxY2tjUjl4NTU0WXNjRnJ2QytQdmFGMkdm?=
 =?utf-8?B?WnlFMlFoT0FRRXlTdm9jK28yclA0T1FWYkQyUFNMdy85b05CQVFNLzFZdllL?=
 =?utf-8?B?ZkwyeDZFa2dwYnorTytpcU43WFd5N2QyQlp3NURqSGp1RVN4eXplS0hxeWdn?=
 =?utf-8?B?MlhlOWIvcS9ubW1hVjdiSVJoRjlhNUVkV3g5STdvWi9XZnd3MDFPeGd5dFVr?=
 =?utf-8?B?YU5Pb1c5UGNwTDFXZ29LcGVtNVhyc2Qva2NweVd0NnFOcW9TbExVN0JXMk11?=
 =?utf-8?B?emR5R0l5QlBVbmNmOVJiUFFtcDZNYWhnQ0c4TGhzbWtvRE9iL1JKb2hWMGZ0?=
 =?utf-8?B?ZUZVMXFUaStockdtQTZwdjVrV0NYaUQwTW9QRGZmeUM3bTlReEFuaVRGTVd5?=
 =?utf-8?B?cnExWVFjbkV1YlNza3FKNlBnSzhaR0crOHdVUUhTQzNyc3VSUFJYN0lGeGtO?=
 =?utf-8?B?UTFHMzRlZGZYZGZrMDd0M1M5UnF4UDA0NE9RYzZ2RGhFZ2VBV2tUNEh6dE1t?=
 =?utf-8?B?MkVBK1FyaEFKYW92c0xUVnFQNm1sTFJybHVkWU16bzFURWJzWUxhd3Q1NEU5?=
 =?utf-8?B?R2VlOUlhc3ZUbFAxY3RlZnhJU3J0S0hoU0s1Q3pVcHRFVnhSUXArd0xYb2k0?=
 =?utf-8?B?UEUwTFBjZlNqc3JqbCtTSDZzVGdpNjFucmtJODNHQXN4ZHpjWmU1ZmRZUk4y?=
 =?utf-8?B?QjVQNDcxcEJHU1pxeXg4VFUyV1NYcXQzNFBHTVBKY0NhcFIwajVpVC9obzgw?=
 =?utf-8?B?VEhzWEgxTVhoTHhZZU11ZHJZVkd4UnFWUkxjaVIxcWt2UU5rSkNJQ3p1LzdO?=
 =?utf-8?B?WUlMajlyRVRMV3ZpTHErNStoK0hjQUR2azQ4eHJpR0hHTTBJamh2Q0lQcU4y?=
 =?utf-8?B?WVl1MkJXY0g3TEVuc01CL05kbTd4QVdsclhsYUJ5czh2YTJKY3lPb2VJYktl?=
 =?utf-8?B?YloxRXh6QzlFd3R5VTVQZmZZeU1FTjFIRGJmTVpvTGdiaWVvQnM5cFJIQzRL?=
 =?utf-8?B?NWwxQVk4dE5TQUhucjNIamFpeVVkWjdwdWsySEpERU50M1NFNzlLcDB4NFhr?=
 =?utf-8?B?MzE2MDRCcnBTckNzdHlRNGZPZVYvenVpZ0RJL3VJaVNQdllORFA0c1JqWDJj?=
 =?utf-8?B?d3Z1Z1ZIL29XRjdqcUhPRkZJSG1FTlJ1UGlPbThBbFNFS3hQYTBQVGlUZlE2?=
 =?utf-8?B?a0xnaCtTbS92U0J2SktrNHZyLzg5WlEySUN0WmF2QnVTcTlITWJNMGc5Z1N2?=
 =?utf-8?B?aEpUSEYxUFJPK21obGRXVFJ1ZEg0ZmdidUdPRDBKQ3R3MTVxbzJ5Qzl4L1J5?=
 =?utf-8?Q?17/Kl0CTNwxH6bkWJ03aG2MIn?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c66dce-76ce-4f6a-6a64-08db3ff2692f
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB1608.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 09:50:58.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvB16lw7BnkyhBvAtVpWlWEpFZejbtq2H92QUQ4YF0g4+znk9PhqfIyoVfWq4gjsDM26aTQfYhV3BowiRCR92w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2888
X-TM-AS-ERS: 104.47.7.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1006-27572.007
X-TMASE-Result: 10--16.985200-4.000000
X-TMASE-MatchedRID: VfovoVrt/oaMcUzJS3sH3RFbgtHjUWLy3AJrtcannra9V4YavKxf4w7O
	3jV2jCDBG04xakpCTBlf4cur8LkD6a0QkrnHPFMssDpn40N9M3lNLPQl0QAltD+B/tp8itBT8Jg
	qp/3e7hdFFrjTpX9jDOPfMxADOGUTVZTAgBT1WR5uq3SU2oCL/jWBEYnpSn2FctZudseHPS3+jr
	zvGANth24AMi4V1HIgJJzhqHiEM5a5rzEqaXlmze0/o+/4D7DzlY0Q2YEHU95GMe+tDjQ3Fhlis
	v9ewQRTgtPnkZJDmxa5cURAloITPk1+zyfzlN7ygxsfzkNRlfLdB/CxWTRRuyUIayx+Skid
X-TMASE-XGENCLOUD: b5ea57cb-ce47-4195-be72-c69dee01fa43-0-0-200-0
X-TM-Deliver-Signature: 46CAC44A36CDDCA982E41BB76054CA30
X-TM-Addin-Auth: p+C6GD1P/9IBWxCLkxfohIU0jFB/o/kxOo8O3fsrvNaOFsmj6XluFLmBQR/
	W3impy0r4XXubh3Vc+8XtJ+/Eiz+rbCYZGWSkutUxoZr9JiGQvYYqkiyu9IGT9S7X6bhp1qkR7Y
	ZZRTFRPd57o3Cu6tsJVQn7kSbCMvHr86N/4T9gE16q6B0BqDNlS80FFynvLwTut6LLNhJozchaz
	H7aBGB7YIyq8yPNivkDn+w4nH91zZXHDr+7bwBXAoKtsViPtK48bDYOAXAKB4lhC9a2FH3C7nl5
	AubZPTxC1ObP9lo=.y4Ybx/wbvK5T52r7+UuZVUPBCPosx3IPdy6J85i1rX8XtBqmOcNbaevxjn
	dIyrvLrPivRQPIkOLxzsKECyjaQKZ80YYuNZfgUC4rxXynZ4OkJD0bDHA9Xg4xB89uVyCIiMc3Y
	K04LLcToHgb0n2TSNP8fFiPSTs7TjMnkCVg0Oa0soqxX0fCsBkYJNJymlrbWtgdU7zTHnxoOvVG
	i3mMcZGL72X3V0sSAn1AzNdVWIJT/wzz6X7aQcV4+ItFSCYawnSZ3Iv4seF/5igqDOiMHQK6Wxg
	6KMaF/lRklaGxUmKXOO89fgwQYfb+l/5gwWBtIE8lTCmxPuPUHXkYRY37Sg==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] can: virtio: Initial virtio CAN
 driver.

Hello,

there is now an implementation of the device for qemu internally under 
review.

The paperwork with the company lawyer to publish source code has also 
been done.

At the same time we changed the driver and the specification draft also, 
especially the bus off indication is now done by a config space bit 
instead of having a dedicated indication queue. Minor updates to some 
other structures. This means what we have will match an updated driver 
and specification version not yet sent out. Also to be done so that 
people can play around.

So an open source qemu device is in the work and we are close to publish 
this in our public github repository but until now nothing has been 
pushed yet to github.

Regards
Harald

On 14.04.23 21:20, Marc Kleine-Budde wrote:
> On 03.02.2023 16:02:04, Harald Mommer wrote:
>> we had here at OpenSynergy an internal discussion about an open source
>> virtio-can device implementation.
>>
>> The outcome of this is now that an open source virtio-can device is to be
>> developed.
>>
>> It has not yet been decided whether the open source device implementation
>> will be done using qemu or kvmtool (or something else?). Negative or
>> positive feedback for or against one of those is likely to influence the
>> decision what will be used as basis for the development. Using kvmtool may
>> be easier to do for me (to be investigated in detail) but on the other hand
>> we have some people around in the team who have the knowledge to support
>> with qemu.
> It there some code available yet? We as Pengutronix will be on our
> yearly techweek soon and I want to look into the VirtIO CAN stuff.
>
> regards,
> Marc
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

