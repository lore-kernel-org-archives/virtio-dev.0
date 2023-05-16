Return-Path: <virtio-dev-return-12720-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A65C77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 12:57:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 26D5E1395E8
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 12:57:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 043079865A6
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 12:57:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E05F1986510; Tue, 16 May 2023 12:57:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD562986511
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 12:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1684241858.590000
X-TM-MAIL-UUID: 117c1a42-6f4d-4701-b3e4-4c54aa127291
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgUSptXK/4cch+Uu7NejizL2CFlxvtFpua4x1wVleJWTgs4g+LsdxFELnyM1zeKV4U5C3QYqKuvOAvH0sLRElftWVrhKtlU1RgRk5kV7RLkRj+3fYIqfu54aNlL/w+gwRulJ8QNQwwUOjEvlET27DLSrXrvRxP0mNOnqy+VaDLqrKDknKXnGo3lW9AojjFaYBDG5K2QPb/JqlTy48CRS7P/I3/9t0CEW3FNWVLHhDlGvOYmo30mC1QVjBeUC4XykPZp4AhvE8UAtj74jljh2jaz4AbDZdbYhixS3rCAew3h+fWvcU0FPELsmp/3p7FsK03DGycqm1sLtqLaRqRWa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvIr/f+e0BZk/xWA8tbwv8NlOY0vYuHj7SZCWcylhko=;
 b=gjiwgKLEG8NLDqI6WXnsI9pHn476F+wYXf/aj5aVMAYVxsQx8qT5ieOWq1ZTEQXIc3KfxtKLUql0TRdIzFySYvLRO9FvxhuLk0lGz995FblJ7a/Zk6K9mH71mQTSx1mY8C8JyV6DrfPbmJGY0PGGky82QWGCWiEOBpFa9VDATl0ItMYBsTq0dTArgZZprbsc4fM1eWBtWLxNZq1NVkSRcePjeqht8FRsGoleCcWcX8d5M80ELJEIi+aUhSHlUylHS1XWc82tqcyfXJxLtj9BNLj/ZAOIdDlqL/EqXeB61bLFn94ocY2bUcjyvkqPL5Ctis4HdFs2iY3YgHCyL8VuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <2119f2a8-4597-2e5d-c80b-4c85c1ae35aa@opensynergy.com>
Date: Tue, 16 May 2023 14:57:32 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
 Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org,
 Keiichi Watanabe <keiichiw@chromium.org>, Marcin Wojtas
 <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>,
 Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, libcamera-devel@lists.libcamera.org
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
 <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
 <87a5ylzf34.fsf@redhat.com> <87354dtp30.fsf@linaro.org>
 <87bkj1h0nf.fsf@redhat.com>
 <a3607ef3-ffd9-345b-0191-5bc946f4be19@opensynergy.com>
 <168329085253.1880445.14002473591422425775@Monstersaurus>
 <87v8h6dagr.fsf@linaro.org>
Content-Language: en-US
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <87v8h6dagr.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::7) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR2P281MB1637:EE_
X-MS-Office365-Filtering-Correlation-Id: 051d26ca-0107-4a7e-b789-08db560d1f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8q1B+JReh9XBQDLiZhP7myZ4Colk/yqs/Befx5xKQbO9Jd+TTlOa/YB7fh2w9sHN1HBNpxT2ouqN+fe4pUaNHwEZBKCbTv0Ln63vbQ+NuxE0hWQL92OOsK2WvytgVbi/7ErOCQjDVd83NjEUZr9IRf01KC7zKCl3AC/UiM9tSMJmigO/IGkvanugg+nx4nFo1RUgJJUFJWpFAMjPS+3brg5lUCVa9whU3XgvcMpglYn2OrA1hBZqhwusKlCfyj4HW8DVWUV1VV+/XTfeyMt39bBFeIrsLQHtS8PeRFdKDbyz32lQtbpzcaTHQEHXZW1J7mKD3LsOhp/AXy0Rakhc97jdyLy6KXAS6sIlDhX+jw15RrIIdZOPDNvl0VKRV9t8fz+rLPVJAkHOl4ESE1OzX4nJv+D++RY+yApqOPDDZDM9zTmgIII31nDL5MngcEOPHpU9dnTRmP2oWL4GQgeP7+1h8bcTAigCSYYR6LVWlf3c4Gp3SIs9of3VqgGCBTKz25YjcUPjskSI0MC+cf/4Ou9nV/xJJMDEhA4z8B/9y80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39830400003)(451199021)(38100700002)(36756003)(31696002)(86362001)(15974865002)(66899021)(31686004)(4326008)(316002)(41300700001)(5660300002)(186003)(8936002)(8676002)(7416002)(54906003)(42186006)(53546011)(26005)(44832011)(30864003)(66574015)(2616005)(2906002)(966005)(66946007)(66556008)(66476007)(478600001)(110136005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVFaengwY2o5MmN3bmdFOHBCMFlEL2NiQVc5eTU4Yk9lR2Q3MUVOdjRqMWVk?=
 =?utf-8?B?QkUzaEtSSDNlYWZpc3dCb2Ira3lGejNHRkR3RXlWZkl4SXhyRHpSblNKTEgx?=
 =?utf-8?B?YWRhUUI3OGkxRmhRYnVPUng2TEc1Q0Q2OURSdno1RHJmWDM4UnFsczh2V0Fp?=
 =?utf-8?B?RWJBMi9id2prUzluaXh4TTRuc0d0SmJxSmhwejNYWnZoR09OV1RSWitRVkxl?=
 =?utf-8?B?WUpGeHZDUFQwa1N4V1hQRGYrNkxpK3R3Rlp4c0tELzZpRHhXeXdhOFRycndF?=
 =?utf-8?B?aWp5RkZIMDA3RzNCWXFaelZuaFdjOUErNG84cEExNG1VN0crSFhhS01PbUJr?=
 =?utf-8?B?MXFXc2ZIWTRpQkxZam5CeFhISnVYNzRYR0VlMVVnS3ZoRHdHeFpLYUNSMDFy?=
 =?utf-8?B?MFVrSW5zTk1LNFA2VVBJSCs3OHVEWkIrUldFOHpwVEdsWCtreGxsNDhtUDdp?=
 =?utf-8?B?T2RZbUlhVGFKQWFEd3dJOHpvRTBoTkYrQ0g2Sitab0VhTVJlTjc2TDFXRnRi?=
 =?utf-8?B?S3B2c0c3bzZZcW9WNVBGMHRNTGpBQTdwU1ZPdUVKSFBCTExueisxdS8wUXlL?=
 =?utf-8?B?b3poVVZsSGxuTXFSTmJKaXhGRlIxUkltZUpVb2t6TUxRTUFrdm01T1B4RDFi?=
 =?utf-8?B?ZWpxSloybDdnMUVOc0MyeXZSRzQxUDJhKzJBcUp6ZGs3MElsYVFJYUhxWTBJ?=
 =?utf-8?B?Z05OQ3htSkh5WjYyazFnWlo4SFRkYTE5bEhZbDMxc3orQW5SaG1VTzBCZVJQ?=
 =?utf-8?B?cUMvVnhtTjdFYlBFd0xDbi96czA0VEE0VEg0d2srT2RiRjFiczU5WTBFRlJv?=
 =?utf-8?B?Q01XZTdaQkFWZDVVK1hCM1VEcWlTaHZseFdVSytPVWNHZnc1dm5qc0ZyeVlZ?=
 =?utf-8?B?TDY3cEtZU3Jld2w2ZGZNMzBCbm83TlNNeDlaWXVFOGlCM2xyMlptZnNySTN3?=
 =?utf-8?B?WktHQ0xuUXUvakN3c0wrOVJGRlNuMU40aEFsTE8vRngyeUt6NWluZDZpb2FC?=
 =?utf-8?B?L0Y2cTl5N0d2RVYzbWxvWExYVnJ0a3EvUERhbnA5US9hRzIzWjVvTmhwMmdF?=
 =?utf-8?B?V1BUUE84enpNUmZaM3RLbUw0TmdoYWFEeXZiNks5d0wzRnN3ejNkWXNMT0p4?=
 =?utf-8?B?TGg4bm1pWFhpWHF0U01ZbjFFN2tsVGk0WXFIMGRIc0xqdHViYTJHQ0N3SlNK?=
 =?utf-8?B?KzNiak9Mdm1Ia3p2SmRINGo0dlBjaW51dDBuN3EyQ0d2VjFKcXlhOFlVOFVv?=
 =?utf-8?B?Z3NENWcvRmJmOS9QdzRQTGJrcHpGQzE4cm5CWTMxSG1GR1ZiRzFuWjgveWpO?=
 =?utf-8?B?RDlnWnFyNHM0TUxyOVhnaHBHejlmTlVFczVzWUlMdHlSOXRVNFgybFYyTlYy?=
 =?utf-8?B?bTVxL1ViVFJnR3AzZjNJQUVwaElXOWtCY0o1MFYxYTJ6SVhDSnY2V004OGVw?=
 =?utf-8?B?TndUb2ZnOXZZUmc1ZTljRjgxM0lyamNiOVdBYkw2UWNBU2FEOTBHTXVTamRQ?=
 =?utf-8?B?c3d4aytYWWVtOU9FY3krM1FoOGY2c0I0WEI3L0NJRGMwc2ozenpDTjM3aUx1?=
 =?utf-8?B?OCtwR0lZT3ZYdU1MM3FndVJFSFFMQVdrcTJsMG5vbkhrMXp4bXMzakdQaVRJ?=
 =?utf-8?B?TUEzUE15ckc5SlVjK1AxekpTbCtOTzI4aHZHdXBiSnlJaUZtc2hqVHhycU5O?=
 =?utf-8?B?cC9VV2xjRWg5TW5tQ1U0ZEFhbmxiMW5ZbU9aaitQQXp5ZjBEZlhhaWpZeXlM?=
 =?utf-8?B?bmdLdW4zNjFuVmlxQVYzQzJQSE5lZjZicTJTZlhvZ21JdmZmNENtNHlsZHp5?=
 =?utf-8?B?aDQyVFhtUWpTbjFudHBsZVBKaGFsQ0NpNTlkQnJQYlBPMlE2NjZnRGVlSk9K?=
 =?utf-8?B?eCtLY2c5ZzRkSStpNE93OERaZGhxZ1ZpM3lPbi9tTk9vVXp5c1E1Z2JiN2M5?=
 =?utf-8?B?Z0c1YllMa3VKdGN6U3FodFhkVjNRWkRtcWpVRS9GUUNZWmdZV3g2Q1lFYlVv?=
 =?utf-8?B?bEJrNURQdWpadW05ejYrR3hWNUhvUkUraXB2YVV4ZUdNVXhZN0k1RnVpK1l3?=
 =?utf-8?B?SFdjeitKYkZPbzU0ZDY5b05jT0VWQUdONUZPK1VoaXJlRjc0cFZwRm0zVThF?=
 =?utf-8?Q?jzTyzGSvmFJfMWhq/ZgKBEvfu?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051d26ca-0107-4a7e-b789-08db560d1f7e
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 12:57:36.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maPcW/UYg/y/0n8sHkCB8IAB0X+iJ+90Hf44xmgF5vd8c7ayG0EptfK0P9J+O/rKSELwf+XZJNTWoF42ZIkUJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1637
X-TM-AS-ERS: 104.47.7.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27628.007
X-TMASE-Result: 10--12.599700-4.000000
X-TMASE-MatchedRID: CxmI61mtwh//9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYNdC
	NuN/95BJLoD4tn9vWJLY1uM/mFqqieay9RWfKUjQg9XZqJGXaHF2ZYwNBqM6Iq0j4OKYdDiChJY
	dickmV330JzNqs6/ROlBE5noyH2He3BPrPGHYpyPGsO9QyW2iBGS3larKSD5HCaqaHEjzQrkY20
	f1wrB11r3+usKi9oxVFhBQE+7pCgfotOADvmQorqoXHZz/dXlxWfgivgcUPZPg935Jgbia0TcpX
	pPCV0E3buT987+t7e/lFNVd1xwO6m7lkbyMKxttFDuTLTe6zcM0GIgTljrHbR1u7K8HqaNc5CiV
	E1F/E9vFeCXSU2QghBYzm9Vx7caIWHT+0u4LwuTidvCqqY53adG3Y6ijqBt3ppiSooS1QHhSOnN
	Cwes0UxaH0fcU8qiwcttVhPGvXehsn9metVJi2GX4nwfT/yarKCYFr1mSkdC/u0i6nZyTESSeag
	bwh0C+rjfpFWYyp3zvg4/ZnYTMlUcx6G5mx77OaDCzqDR7DPY9DpdZx5HaZS99T+uJIleR7FFhl
	jeLP1zMmbaec67Hcs+0upIYi1yJsSfa8QAGALoEOhHzDsL05pq7DiIZuJv44TQVKfJL+uYZGgGa
	H7R5LRliU1mWF9img+v5rI7p03YumHyO4Y/CAxHdIZ6edcbr0yxg8hRYM2nICMF8PHDOJdvSBpm
	BATJqnT+9AZ3A3o0PsMiSITv1VfAP+OlZKmSDuxuzDjo6BhQw71tjkTGpo8PB5MJ56SQG3j63YQ
	vEOy9pXlFEA2+QbgKX0XtIpVaHNNXWLKffVMp+yskgwrfsC30tCKdnhB581B0Hk1Q1KyLUZxEAl
	FPo8/cUt5lc1lLgkU6UkIr/V+20QRlrBF3eZUY+gn8DlZX5a5CcFEGT8EQLAs+4SCjpvOj+9TtW
	JUSwXH0apHhmw6I=
X-TMASE-XGENCLOUD: 7b132527-4761-4ef8-986d-bb73ce67b358-0-0-200-0
X-TM-Deliver-Signature: 74D856AFD2F104A4E6CEA70B2737AC0F
X-TM-Addin-Auth: 60VNaHD9l6UuaG1XoEkLttuRVTRSQNfPEsfZmt7PSsJGlMXOqmw3nhtEaFU
	hOtfN4zoPB1/fVMzphNspjahDtl7xlAU8iIsVu8OecYKZfv/ADvPkkpQRhVKNYW8ljFFUNri859
	XmuZ+O4Ybi1t9XIGzdePiQbYnikWOhAdy2oebXaGep85QeZzAddkDDC0k+UXhX0l0KS+tXiI2u5
	plcNh2LRObk3YjD5wAmBmmyRWpk+SLjvxM2MMCuDv7Nyxd7RrOG5kkQI6EI5T8FjXq/VlUUtBqh
	sEp+JnoB2W8YfW4=.IKbI6pJtrYAXY5HplYmb+5DJyrahckxa+Rx+nP0aDnUpTXgWMfkZQJ4AyL
	YW+XcLHK6XnS380yPwZvgKJMB6YQuyp8ffFxMPaFa3aHD0giMMqm7t1bLUsy5xwoC5tK0b7Ffdc
	kMxOxPvZoZ0N86OjxxIBFu+ZKVxvjmFYSwHFMlhfBhD+WoZearWdju0pbXP1M4HvLOj6U66TXzT
	iuo9LuCM6Y0V9Mq3IcHiIQYHjPpF8ttoK+9Y9iAEOrIR8ePyEqtvfOeS+4ZWZYPEwxZ11VZ3kqP
	41i6lwkZbfVYwcSwbmD9nL31idgfORvnlAXZR93S39GiK+V/K5o9y22/8jA==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 05.05.23 17:55, Alex Benn=C3=A9e wrote:
>
> Kieran Bingham <kieran.bingham@ideasonboard.com> writes:
>
>> Hi All,
>>
>> Coming in late, thanks to lei/lore spotting the libcamera keyword.
>>
>> + Cc: libcamera-devel to raise awareness of the discussion there.
>>
>> Quoting Alexander Gordeev (2023-05-05 10:57:29)
>>> On 03.05.23 17:53, Cornelia Huck wrote:
>>>> On Wed, May 03 2023, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>>>
>>>>> Cornelia Huck <cohuck@redhat.com> writes:
>>>>>
>>>>>> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynerg=
y.com> wrote:
>>>>>>
>>>>>>> On 27.04.23 15:16, Alexandre Courbot wrote:
>>>>>>>> But in any case, that's irrelevant to the guest-host interface, an=
d I
>>>>>>>> think a big part of the disagreement stems from the misconception =
that
>>>>>>>> V4L2 absolutely needs to be used on either the guest or the host,
>>>>>>>> which is absolutely not the case.
>>>>>>>
>>>>>>> I understand this, of course. I'm arguing, that it is harder to
>>>>>>> implement it, get it straight and then maintain it over years. Also=
 it
>>>>>>> brings limitations, that sometimes can be workarounded in the virti=
o
>>>>>>> spec, but this always comes at a cost of decreased readability and
>>>>>>> increased complexity. Overall it looks clearly as a downgrade compa=
red
>>>>>>> to virtio-video for our use-case. And I believe it would be the sam=
e for
>>>>>>> every developer, that has to actually implement the spec, not just =
do
>>>>>>> the pass through. So if we think of V4L2 UAPI pass through as a
>>>>>>> compatibility device (which I believe it is), then it is fine to ha=
ve
>>>>>>> both and keep improving the virtio-video, including taking the best
>>>>>>> ideas from the V4L2 and overall using it as a reference to make wri=
ting
>>>>>>> the driver simpler.
>>>>>>
>>>>>> Let me jump in here and ask another question:
>>>>>>
>>>>>> Imagine that, some years in the future, somebody wants to add a virt=
io
>>>>>> device for handling video encoding/decoding to their hypervisor.
>>>>>>
>>>>>> Option 1: There are different devices to chose from. How is the pers=
on
>>>>>> implementing this supposed to pick a device? They might have a narro=
w
>>>>>> use case, where it is clear which of the devices is the one that nee=
ds to
>>>>>> be supported; but they also might have multiple, diverse use cases, =
and
>>>>>> end up needing to implement all of the devices.
>>>>>>
>>>>>> Option 2: There is one device with various optional features. The pe=
rson
>>>>>> implementing this can start off with a certain subset of features
>>>>>> depending on their expected use cases, and add to it later, if neede=
d;
>>>>>> but the upfront complexity might be too high for specialized use cas=
es.
>>>>>>
>>>>>> Leaving concrete references to V4L2 out of the picture, we're curren=
tly
>>>>>> trying to decide whether our future will be more like Option 1 or Op=
tion
>>>>>> 2, with their respective trade-offs.
>>>>>>
>>>>>> I'm slightly biased towards Option 2; does it look feasible at all, =
or
>>>>>> am I missing something essential here? (I had the impression that so=
me
>>>>>> previous confusion had been cleared up; apologies in advance if I'm
>>>>>> misrepresenting things.)
>>>>>>
>>>>>> I'd really love to see some kind of consensus for 1.3, if at all
>>>>>> possible :)
>>>>>
>>>>> I think feature discovery and extensibility is a key part of the Virt=
IO
>>>>> paradigm which is why I find the virtio-v4l approach limiting. By
>>>>> pegging the device to a Linux API we effectively limit the growth of =
the
>>>>> device specification to as fast as the Linux API changes. I'm not ful=
ly
>>>>> immersed in v4l but I don't think it is seeing any additional feature=
s
>>>>> developed for it and its limitations for camera are one of the reason=
s
>>>>> stuff is being pushed to userspace in solutions like libcamera:
>>>>>
>>>>>     How is libcamera different from V4L2?
>>>>>
>>>>>     We see libcamera as a continuation of V4L2. One that can more eas=
ily
>>>>>     handle the recent advances in hardware design. As embedded camera=
s have
>>>>>     developed, all of the complexity has been pushed on to the develo=
pers.
>>>>>     With libcamera, all of that complexity is simplified and a single=
 model
>>>>>     is presented to application developers.
>>>>
>>>> Ok, that is interesting; thanks for the information.
>>>>
>>>>>
>>>>> That said its not totally our experience to have virtio devices act a=
s
>>>>> simple pipes for some higher level protocol. The virtio-gpu spec says
>>>>> very little about the details of how 3D devices work and simply offer=
s
>>>>> an opaque pipe to push a (potentially propriety) command stream to th=
e
>>>>> back end. As far as I'm aware the proposals for Vulkan and Wayland
>>>>> device support doesn't even offer a feature bit but simply changes th=
e
>>>>> graphics stream type in the command packets.
>>>>>
>>>>> We could just offer a VIRTIO_VIDEO_F_V4L feature bit, document it as
>>>>> incompatible with other feature bits and make that the baseline
>>>>> implementation but it's not really in the spirit of what VirtIO is
>>>>> trying to achieve.
>>>>
>>>> I'd not be in favour of an incompatible feature flag,
>>>> either... extensions are good, but conflicting features is something
>>>> that I'd like to avoid.
>>>>
>>>> So, given that I'd still prefer to have a single device: How well does
>>>> the proposed virtio-video device map to a Linux driver implementation
>>>> that hooks into V4L2?
>>>
>>> IMO it hooks into V4L2 pretty well. And I'm going to spend next few
>>> months making the existing driver fully V4L2 compliant. If this goal
>>> requires changing the spec, than we still have time to do that. I don't
>>> expect a lot of problems on this side. There might be problems with
>>> Android using V4L2 in weird ways. Well, let's see. Anyway, I think all
>>> of this can be accomplished over time.
>>>
>>>> If the general process flow is compatible and it
>>>> is mostly a question of wiring the parts together, I think pushing tha=
t
>>>> part of the complexity into the Linux driver is a reasonable
>>>> trade-off. Being able to use an existing protocol is nice, but if that
>>>> protocol is not perceived as flexible enough, it is probably not worth
>>>> encoding it into a spec. (Similar considerations apply to hooking up t=
he
>>>> device in the hypervisor.)
>>>
>>> I very much agree with these statements. I think this is how it should
>>> be: we start with a compact but usable device, then add features and
>>> enable them using feature flags. Eventually we can cover all the
>>> use-cases of V4L2 unless we decide to have separate devices for them
>>> (virtio-camera, etc). This would be better in the long term I think.
>>
>> Camera's definitely have their quirks - mostly because many usecases are
>> hard to convey over a single Video device node (with the hardware) but I
>> think we might expect that complexity to be managed by the host, and
>> probably offer a ready made stream to the guest. Of course how to handle
>> multiple streams and configuration of the whole pipeline may get more
>> difficult and warrant a specific 'virtio-camera' ... but I would think
>> the basics could be covered generically to start with.
>>
>> It's not clear who's driving this implementation and spec, so I guess
>> there's more reading to do.
>>
>> Anyway, I've added Cc libcamera-devel to raise awareness of this topic
>> to camera list.
>>
>> I bet Laurent has some stronger opinions on how he'd see camera's exist
>> in a virtio space.
>
> Personally I would rather see a separate virtio-camera specification
> that properly encapsulates all the various use cases we have for
> cameras. In many ways just processing a stream of video is a much
> simpler use case.
>
> During Linaro's Project Stratos we got a lot of feedback from members
> who professed interest in a virtio-camera initiative. However we were
> unable to get enough engineering resources from the various companies to
> collaborate in developing a specification that would meet everyone's
> needs. The problem space is wide from having numerous black and white
> sensor cameras on cars to the full on computational photography as
> exposed by modern camera systems on phones. If you want to read more
> words on the topic I wrote a blog post at the time:
>
>    https://www.linaro.org/blog/the-challenges-of-abstracting-virtio/

Thanks for the link, it is a very insightful read. Actually there are
folks attempting to virtualize cameras in my company too. Probably they
should reach out to you.

> Back to the topic of virtio-video as I understand it the principle
> features/configurations are:
>
>    - All the various CODECs, resolutions and pixel formats

These would be the basics. Encoders usually have even more parameters
with sensible defaults. So the mentioned ones should be enough in the
simple case.

>    - Stateful vs Stateless streams

Yes. Still I think everybody agrees at the moment, that we should
consider the stateful interface first. For me the valid reason is that
there is hardware, that only exposes stateful interface. And stateless
interface can be always converted to stateful by keeping the state on
the host side.

>    - If we want support grabbing single frames from a source
>
> My main concern about the V4L approach is that it pegs updates to the
> interface to the continuing evolution of the V4L interface in Linux. Now
> maybe video is a solved problem and there won't be (m)any new features
> we need to add after the initial revision. However I'm not a domain
> expert here so I just don't know.

This is also my concern. AFAIU Alexandre proposed to "patch" the V4L2
stateful interfaces were we see fit. But this decreases readability
significantly IMO. So I'd prefer to avoid this.

--
Alexander Gordeev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 - 88
Fax: +49 (30) 60 98 54 0 - 99
EMail: alexander.gordeev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

