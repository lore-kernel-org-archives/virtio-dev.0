Return-Path: <virtio-dev-return-12250-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A00C77B72
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 12:52:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 19C7B9F4E7
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 12:52:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 034BE986353
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 12:52:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E4B4F98632B; Mon, 17 Apr 2023 12:52:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2CA598634A
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 12:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1681735919.787000
X-TM-MAIL-UUID: b33d0b89-b726-4622-9703-1e22644bb2fe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmGoVW5of6fKRVFGDopP/ihYSzpjCwAhkRc8dGvimWksIitOXsYNKe2LCXKH3+OSsxWn2nfvswDwiHI/2bkUV9lsJDUA+VYgrn3K8XU++dVLa969AjEkPQIlTXBt2AQ3NP/ZGgNU2ZSUuV8zFox/xVwue25aXYv5rXUUGjH8YtITrHL3KsVgDSXViNNWGBrh3BZK1Emeev/6KdV/dFhJHZnprX43zd3/JYaI0ps/e9RbJlMsVFeCg0/aBEvXw9kKsFP8GyMPCnUI5pbKs0NtomrUTV28j8JlbktFICyPJs0AaeFdnnKH5J6moX6uFdVeo+OEJC1+4rum4LyACgQ67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwsbJ/cuy3pNfC1xwyLHH+fqrWlTJ3yQ0czTihiKcqY=;
 b=FOrNRXYUb5dKm8DBxOdLIgn+DOeknmILUcl5FfbILBwS4Md8YJM8CEAt4ShDS7XZz1elOLaE1QiZAAn53/53sI6ujeHOesL4mHgDpZ3c/02h4sqb0jWbNdT4LEe75Um5QyegKhvztoR3j3JtikdlGVq8W3T4esYWCgBG0tplJG+7TjcWeDawmJyGbJEA94XXizpbecgd8p5uf98qWUN/c1joaaBagijdfyNgSGa9RxmteZzX6/q5EIUzuJQAAWZ5ugnJDpjecuq8kQdgdhoqQi0Ff/ZT7cm6DXzvv+3/qpL82RPnEnXmZVxCduOSRh+ik3mgRmCVJw8gNbCJcHQ/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
Date: Mon, 17 Apr 2023 14:51:53 +0200
Content-Language: en-US
To: Alexandre Courbot <acourbot@chromium.org>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 Keiichi Watanabe <keiichiw@chromium.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>,
 Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::20) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BEZP281MB2552:EE_
X-MS-Office365-Filtering-Correlation-Id: 373b5135-b8b3-49ca-c180-08db3f428721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o71HnegYUKt6dIZhJyzj8f1jbuuUv39m5RYEr1ydC8iAEaCqiriLqCWEhODOedBA6cdSlddZgN515fBHQ78lcpktRWk5GYHR5ITD8BGsC/YDO/dRiHRTykhyvtCI4qrmvjgBmI9xif2JghPDPIXxTd4eHvVJF+kUFl7OgxOmFOmqSCZs6pj4t0wEJ3gdhaAjfTQxUcDJx2dfi7rLxSZA8RZAPnwl9rU0TtrOfRTi8dYPZrnWTOXwawWda3pK3Arn/ZdOnoqJJURm+br+gFquRJJK+3Liq9NZpjVu7jBXFhgYko4Sdh3gRLC9pHnRcCsaQRJrOlRyuT6l4+mYMst1ybRCalpQKFeHOESXl++dFBLQl5wClLekALvA5IIJ3kYgCGTyHZFqBRYDBq4OK+0iY21oOr2+MuhetVVaoMY78CtSaeGAFccTKZIY6VMDbLvTMNDuiGTteTPv/sk8h1rJGUz9AK4b1CPbMfVy5z3QUo5jRWdAQlBmu/PLlKaszvJ52JiR9GNdX6HUXotq8IiBysdPoMK0cL+P/lwT+oQXOp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(39840400004)(136003)(451199021)(8676002)(7416002)(8936002)(41300700001)(44832011)(5660300002)(31686004)(66946007)(66556008)(2906002)(4326008)(6916009)(316002)(66476007)(30864003)(66899021)(31696002)(54906003)(86362001)(42186006)(478600001)(15974865002)(38100700002)(53546011)(186003)(36756003)(83380400001)(26005)(66574015)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkE2T3lsMUxEemsvNVRBUG55bFg2TUp2S0NkTzgvMGNrMWloK054NmF4Tmhu?=
 =?utf-8?B?dUNyZCtGaVV2ZStxRVlhZk4xcWZ3ZG90UXNLY3AvelB6NGtaWVhrdDMrUmZG?=
 =?utf-8?B?OXB4aXRQNFg4TjgycWZmSG9qbzZxQVo0bm10eGVzUjhhUXpuMmFGTnVhaG1Z?=
 =?utf-8?B?WmF6UGZHdHZnZDlIYW5YSTdNWlRaWjA4dmdscmFxY2ZXanFaOTJWdFFrNmRu?=
 =?utf-8?B?Z3pFWnFJUkV6YmlkSkFRU0IyUEhIOCtibmFFbndPL1Z0MDBBeGZ0ZHJFQTM5?=
 =?utf-8?B?TFVMajQ0R3VZaXlvemdDYXNVdGJVVTdyL0pwS3ZCaE0yRFRpQmxEQXZYSmJ1?=
 =?utf-8?B?L1FEWWNqMjQxUHhTZnVYVVhLQnZSNzFxVFo1aTFadmhwU05aazUxUEwwbEho?=
 =?utf-8?B?dkJyYitpSVRKcXByVU15NzVGc0NpOHlza2lUNElHaUpCQ2loK25JVnhYUzRY?=
 =?utf-8?B?b2Zkcnlyd1daak4xZGZ0V3NLY1lqcHQyRGh5b1dicEt5bmJKSVRNbHZka3lP?=
 =?utf-8?B?d1BTNmQvMU1tWWN5TU9NT3htYnJUSXlGNFhXRnZ4UXdOOUJHdEMxSkg1K3B4?=
 =?utf-8?B?eWxaVVVHOUFrMnJ2Mktzbnprd2xDOUdDZzVPUkZJTmFrcEZTSGNkMHFoNVpl?=
 =?utf-8?B?TnozNmphdDhqTXpBWVVlQzcrbE9Xa0k2S2R6SElEdmxNOHNKLzVhN2thMUht?=
 =?utf-8?B?Ulovd2MzSUVyTUJ4TmRMTCsvOFVwQ21MMGpkYnk5NUN1aUNWTlZSQTRRZExo?=
 =?utf-8?B?WEw0RkJlN1RoUS9qaTAvK3JiSXNwdGZ5RzNNNjNlQ0Z4UTJleW01YVpOSTFE?=
 =?utf-8?B?TG5FdHplSGZQMnRScktkSDVVZzd3SklibEQ2SitxaS9EbVFvWHlVR280NnpP?=
 =?utf-8?B?KzNKTC8xQmk0a2JQL0ovT1pDTFZNajFsUFJveVhRaTQvNXoxRUsycTRPV1M3?=
 =?utf-8?B?SVRoMGpSWExWSmcyK05VYUFnUFl4bWNMUkVJMDlOVmtyekdtNDNNcUp3S2I2?=
 =?utf-8?B?Qlp6bzM1N3N3WlVBRUp5TThVajBGYmRUSUtHWGVsZGhZNXhKT085d1BTYk9N?=
 =?utf-8?B?TE1iemphSDkwQWZRUStGN3pBVk1uSXVPWWxjR3VzSy9GSWY4UGFvSW9GQjRQ?=
 =?utf-8?B?QjZ2NTladWI5S28yNGg2dGFza2w1VFpkc3YvQk1pQ1hyZHBpbnZaZjB5NjU0?=
 =?utf-8?B?RE52eDRkKzFzZW5ETmRTbHVSckE0VGFlZ0czbmRpNTJacGRpSlpMekQ5Y0ZW?=
 =?utf-8?B?STRuTXpPUzZUemhqVStpaEdzNWRUYnk3T2JwYTl3cjdaY3MrZFROdk03a1Vk?=
 =?utf-8?B?dUhKSkpkWUhkT1NOcGtTdkdxQWhXcGV1amd6MVZXMG9EN0k3TSt4dkZ1OC9I?=
 =?utf-8?B?dm1xOHFwUGY3VzA5VzdscC94VmRiR202NXpWbXhYc2Zpd0JtS2lNODdnMlhH?=
 =?utf-8?B?WFNzbCtqRW9QbkVBVlVFeS93amg4TUtPWUNyN1VhdXA2VjIwMnJsQ3FqMHVL?=
 =?utf-8?B?OXRWcUxOUlRZTmVySEk3ejhwdXNFUXFXNHQ3RUVHNjNDVHhyR09kSDVUenlx?=
 =?utf-8?B?YVFhS1BKV0JiK2srRzlnTys1U3J5Vlh3S09EZ2p2M01Fd051WDBpSzM4QzBS?=
 =?utf-8?B?RUIxc1JJZVVCR002WEZ4ZWpoQytsbEp6cGJBUXJDNnJSalBINVFhekZSeGJx?=
 =?utf-8?B?RS9OV0ZqVkZHRmljNnB2RFhmc2xmaDNhTlEvZ0Vzd096bllBK0xlRHFxVkdS?=
 =?utf-8?B?Wk9PNDY3WU14UzlhZ0RxV2RrSnlsUEszWUxQa0lpak9BZ2xkWnRrd3JaMjQz?=
 =?utf-8?B?czBYd3UvdEo1MXpsYnpVRFg3WWdYL0lKdWVOZ095cWtQOVlhK0g5cUFLanF0?=
 =?utf-8?B?VzlmUVZvdjFGeTlla0ZnajUwMFBhd1Q4Zmtxak1vV2RBRm1SVUNPWU9lbnFr?=
 =?utf-8?B?eERkdzdCbUxkTTFQYW5zK1NWUHIwbVR4RW5XbU1nTzBUUzFzQ2J2djhKbjZZ?=
 =?utf-8?B?cFNZWWI5SXhrT2IvbnREWEJnUzJ0TmpMQ1ZHbFpaaW94N2JyZm5JNDNXTURk?=
 =?utf-8?B?Snc3RjI5RVZ4aVBrcWVYY3llZ2JqbUhFeS9aaVlqSXAwaGJ5RDNIekEzQlBL?=
 =?utf-8?Q?JFPEgGv2cc584h2QTHfbF4KSe?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373b5135-b8b3-49ca-c180-08db3f428721
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 12:51:57.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1aaXdY+/DSEiQqUrK4maFd/UgMlpCC2iJH0cEHLGNRdLPOpxZ/3STCWb2kJTfdFSyyTsh65oO45gyQak09sTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2552
X-TM-AS-ERS: 104.47.7.171-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1006-27570.007
X-TMASE-Result: 10--38.087200-4.000000
X-TMASE-MatchedRID: CxmI61mtwh//9O/B1c/Qy6n9fPsu8s0akYC3rjkUXRIUta+LQgEZMNSH
	nJDq2yhM1eKt+ktDRM/weq4xw7Vs7bW23FWR+Sb2h2VzUlo4HVPgcQxvUTCfSh/THH4EgJNXOXB
	2cqV0mCK2nJIymOSHNTAAk8j+D63T3BPrPGHYpyMRW4LR41Fi8oHK2QhtcJsHBFBELUK022eRWo
	MGf/8eEj1U0pjCxwxwCeeBbUlZyWrYEhFHE+qJerT2H4BSd5GPyeUl7aCTy8iNJ2ckLRg2UcQa1
	++oHl5UOpkEtKnYwFvDUOvB8SON9WwYJ6a6zhumOGTV4fFD6yCzq2Kpsx7uWmXAXZr4VdzOecgH
	/LinjgP5JJqpHpLxNHzBrHg8O886sR2DdiVFEcvG9W0D68BZzPNkoMDX+kiuUCgEErrUGFwtbEB
	nKg+1LdYuKEikEh+ZQ4BgKt0l6hSiO3Qgdcs2/grcxrzwsv5u0w14HFJQjaMfaBJLrllK9RD46v
	/Okpva0zQvIGSf29AY4lCW9PpF6aXUs7kD79U2n6y0mNkW0aQA+JHhu0IR5nh7+7pZ9mZRTJ3M8
	N7UYpLE/nOeY1CPQCSc4ah4hDOWTM/0wz1kxFUOeRRGICV9PTa9tZoo+dDbs9Pzn6obnBVrqMMR
	8f2KK4iR1Or8fjI7li+7lFlabVlKDCF1/McINDe9MF4SNA1+EeXPNyiMU068cbBlXDs0qergVvi
	4gBgEOYiiTYjIMplluRlfzMjt5xTrtyVYkj4JB7AFWMPZIMZvk3JiXDj4dceQfu6iwSfszwha4E
	i7r7dlfaF/BQ/tikBBOuAL4LeNZdk0QuDh+8GeAiCmPx4NwFkMvWAuahr83Mh122xXdCt4N1jhR
	VQFLd934/rDAK3zGjFMngtLLWhJFQD69E10vA==
X-TMASE-XGENCLOUD: NULL-NULL-5-0-1
X-TM-Deliver-Signature: FFE09D6BEFE2FAE0B862DDF49B10B862
X-TM-Addin-Auth: ywVrLkwXUUEdhDBW7UV1evHEWcwBzWIKgDjPrCE5BbbK+/h4X947wNtYYhi
	63XT7DmXtzng5GIjPm/iHNGvqwRwWVMSUDEpJCzjrGJZVqcXQk74KCC8uipaHHwMGl+W4vdoQdM
	DhvCixLJ0xJw7UNC6AkzskB2yobQ13kf2CQ04CSiOX742zjR/JiSNbMSJ2RXkITkBy8H/CBEurK
	O4I86KOkSdVpXgf7IUpe/gkwxPMyJ3Vdx6FvzXB4z2looMXswph3XMXtBcMWNV4FoIyc/YD/3wC
	TTn5CIRvzJCVCjc=.KKWpkAuca2WO5QNqY0Jx6iWe1G+7Y7DSp7mexZiiRtzvRRisb4D58DuvVn
	K5NJcT6sn7USSzuVNCaRJIFS3FyItonx9izxCa183ahlowpo9VTVJTnMy9P15VqLjXt4V+4VhaK
	8HBmXslFW3BLgGvi/lPFZpkFiWki74lGGWwE7Bpt19++w18/u5BtvJyLnR9VcIZqo4TUnQxc3r3
	COcmRIBQSUyTOPIhI2YzxGE96g1/NFIRjgyMISbwfE4zp34m2QBEvJHdwgP9poO8imAkOneK58Z
	nlmTdlpGPTncG1HhyD679BgKqpSI1k3ZiUskTqB/nythEsgEpmjWcR7Okig==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

Hi Alexandre,

Thanks for you letter! Sorry, it took me some time to write an answer.

First of all I'd like to describe my perspective a little bit because it
seems, that in many cases we (and other people writing their feedbacks)
simply have very different priorities and background.

OpenSynergy, the company that I work for, develops a proprietary
hypervisor called COQOS mainly for automotive and aerospace domains. We
have our proprietary device implementations, but overall our goal is to
bring open standards into these quite closed domains and we're betting
big on virtio. The idea is to run safety-critical functions like cockpit
controller alongside with multimedia stuff in different VMs on the same
physical board. Right now they have it on separate physical devices. So
they already have maximum isolation. And we're trying to make this
equally safe on a single board. The benefit is the reduced costs and
some additional features. Of course, we also need features here, but at
the same time security and ease of certification are among the top of
our priorities. Nobody wants cars or planes to have security problems,
right? Also nobody really needs DVB and even more exotic devices in cars
and planes AFAIK.

For the above mentioned reasons our COQOS hypervisor is running on bare
metal. Also memory management for the guests is mostly static. It is
possible to make a shared memory region between a device and a driver
managed by device in advance. But definitely no mapping of random host
pages on the fly is supported.

AFAIU crosvm is about making Chrome OS more secure by putting every app
in its own virtualized environment, right? Both the host and guest are
linux. In this case I totally understand why V4L2 UAPI pass-through
feels like a right move. I guess, you'd like to make the switch to
virtualized apps as seemless as possible for your users. If they can't
use their DVBs anymore, they complain. And adding the virtualization
makes the whole thing more secure anyway. So I understand the desire to
have the range of supported devices as broad as possible. It is also
understandable that priorities are different with desktop
virtualization. Also I'm not trying to diminish the great work, that you
have done. It is just that from my perspective this looks like a step in
the wrong direction because of the mentioned concerns. So I'm going to
continue being a skeptic here, sorry.

Of course, I don't expect that you continue working on the old approach
now as you have put that many efforts into the V4L2 UAPI pass-through.
So I think it is best to do the evolutionary changes in scope of virtio
video device specification, and create a new device specification
(virtio-v4l2 ?) for the revolutionary changes. Then I'd be glad to
continue the virtio-video development. In fact I already started making
draft v7 of the spec according to the comments. I hope it will be ready
for review soon.

I hope this approach will also help fix issues with virtio-video spec
and driver development misalignment as well as V4L2 compliance issues
with the driver. I believe the problems were caused partly by poor
communication between us and by misalignment of our development cycles,
not by the driver complexity.

So in my opinion it is OK to have different specs with overlapping
functionality for some time. My only concern is if this would be
accepted by the community and the committee. How the things usually go
here: preferring features and tolerating possible security issues or the
other way around? Also how acceptable is having linux-specific protocols
at all?

Also I still have concerns about memory management with V4L2 UAPI
pass-through. Please see below.

On 17.03.23 08:24, Alexandre Courbot wrote:
> Hi Alexander,
>
> On Thu, Mar 16, 2023 at 7:13=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>> Hi Alexandre,
>>
>> On 14.03.23 06:06, Alexandre Courbot wrote:
>>> The spec should indeed be considerably lighter. I'll wait for more
>>> feedback, but if the concept appeals to other people as well, I may
>>> give the spec a try soon.
>> Did you receive an email I sent on February 7? There was some feedback
>> there. It has been already established, that V4L2 UAPI pass-through is
>> technically possible. But I had a couple of points why it is not
>> desirable. Unfortunately I haven't received a reply. I also don't see
>> most of these points addressed in any subsequent emails from you.
>>
>> I have more to say now, but I'd like to make sure that you're interested
>> in the discussion first.
> Sorry about that, I dived head first into the code to see how viable
> the idea would be and forgot to come back to you. Let me try to answer
> your points now that I have a better idea of how this would work.
>
>>> If we find out that there is a benefit in going through the V4L2
>>> subsystem (which I cannot see for now), rebuilding the UAPI structures
>>> to communicate with the device is not different from building
>>> virtio-video specific structures like what we are currently doing.
>> Well, the V4L2 subsystem is there for a reason, right? It does some
>> important things too. I'm going to check all the v4l2_ioctl_ops
>> callbacks in the current virtio-video driver to make the list. Also if
>> you have some PoC spec/implementations, that would be nice to review. It
>> is always better to see the actual implementation, of course.
>>
>> I have these points so far:
>>
>> 1. Overall the V4L2 stateful decoder API looks significantly more
>> complex to me. Looks like you're a V4L2 expert, so this might not be
>> visible to you that much.
> V4L2 is more generic than virtio-video, so as a result specific uses
> tend to require a bit more operations. I would argue the mental
> overhead of working with it is less than significant, and most of it
> consists in not forgetting to call STREAMON on a queue after some
> operations. Things like format, resolution and buffer management do
> not get more complex (and V4L2 is actually more complete than our
> previous proposal on these).
>
> The counterpart of this marginal extra complexity is that you can
> virtualize more kinds of devices, and even within virtio-video support
> more formats than what has been specified so far. If your guest is
> Linux, the same kernel driver can be used to expose any kind of device
> supported by V4L2, and the driver is also much simpler than
> virtio-video, so you are actually reducing complexity significantly
> here. Even if you are not Linux, you can share the V4L2 structures
> definitions and low-layer code that sends V4L2 commands to the host
> between drivers. So while it is true that some specifics become
> slightly more complex, there is a lot of potential simplification when
> you look at the whole picture.
>
> It's an opinionated proposal, and it comes with a few compromises if
> you are mostly interested in codecs alone. But looking at the guest
> driver convinces me that this is the better approach when you look at
> the whole picture.

Sorry, I just see it differently as I tried to describe above. The
problem is that we don't yet see the whole picture with the V4L2 UAPI
pass-through. I reviewed the code briefly. It is great, that you already
implemented the MMAP mode and host allocations already. But I would
argue, that this is the simplest case. Do you agree? Also this mode of
operation is not supported in our hypervisor for reasons mentioned
above. So in our case this PoC doesn't yet prove anything unfortunately.
I think the real complexity is yet to come.


>>     a. So V4L2 subsystem and the current virtio-video driver are already
>> reducing the complexity. And this seems as the right place to do this,
>> because the complexity is caused by the amount of V4L2 use cases and its
>> legacy. If somebody wants to use virtio-video in a Windows guest, they
>> would prefer a simpler API, right? I think this use-case is not purely
>> abstract at all.
> The V4L2 subsystem is there to factorize code that can be shared
> between drivers and manage their internal state. Our target is the
> V4L2 UAPI, so a Windows driver needs not be concerned about these
> details - it does what it would have done with virtio-video, and just
> uses the V4L2 structures to communicate with the host instead of the
> virtio-video ones.

It can also reuse the virtio-video structures. So I think despite the
ability to reuse V4L2 structures, having to implement a linux-specific
interface would still be a bigger pain.


>>     b. Less complex API is better from a security point of view too. Whe=
n
>> V4L2 was developed, not many people were concerned with malicious USB
>> devices probably. At least exploiting a malicious USB device usually
>> requires physical access. With virtual devices and multiple VMs the
>> stakes are higher, I believe.
> That's probably true, but I fail to see how the fact we are using
> struct v4l2_buffer instead of struct virtio_video_buffer can have an
> impact on that?
>
> V4L2 has a larger UAPI surface because it manages more kinds of
> devices, but drivers only need to implement the ioctls they need. For
> the rest, they just return -ENOTTY, and evil actors are hopefully kept
> at bay.

Still there are definitely more ways to do things wrong. It would be
harder to audit a larger API surface.


>> 2. We have a working virtio-video driver. So we need very good reasons
>> to start from scratch. You name two reasons AFAIR: simplicity and
>> possible use of cameras. Did I miss something else?
>>
>>     a. The simplicity is there only in case all the interfaces are V4L2,
>> both in the backend and in the guest. Otherwise the complexity is just
>> moved to backends. I haven't seen V4L2 in our setups so far, only some
>> proprietary OMX libraries. So from my point of view, this is not
>> simplicity in general, but an optimization for a specific narrow use cas=
e.
> V4L2 is not a narrow use-case when it comes to video devices on Linux
> - basically every user space application involving cameras or codecs
> can use it. Even the virtio-video driver exposes a V4L2 device, so
> unless you are using a different driver and proprietary userspace apps
> specifically written to interact with that driver, V4L2 is involved in
> your setup at some point.

Sorry, I mean narrow use-case if we look into other possibilities:

1. Stateless V4L2 on the host.
2. Any other interface on the host.
3. Any other guest except Linux.

Our targets are several popular embedded SoCs. Unfortunately we don't
have the luxury of simply having normal V4L2 devices there. And it
doesn't look like this is going to change.


> The guest driver that I wrote is, I think, a good example of the
> complexity you can expect in terms of guest driver size (as it is
> pretty functional already with its 1000 and some LoCs). For the UAPI
> complexity, the host device basically unpacks the information it needs
> and rebuilds the V4L2 structures before calling into the host device,
> and I don't see this process as more complex that the unpacking of
> virtio-video structs which we also did in crosvm.

Unfortunately our hypervisor doesn't support mapping random host pages
in the guest. Static allocations of shared memory regions are possible.
But then we have to tell V4L2 to allocate buffers there. Then we'll need
a region per virtual device. This is just very tedious and inflexible.
That's why we're mainly interested in having the guest pages sharing in
the virtio video spec.


>>     b. For modern cameras the V4L2 interface is not enough anyway. This
>> was already discussed AFAIR. There is a separate virtio-camera
>> specification, that indeed is based on V4L2 UAPI as you said. But
>> combining these two specs is certainly not future proof, right? So I
>> think it is best to let the virtio-camera spec to be developed
>> independently.
> I don't know if virtio-camera has made progress that they have not
> published yet, but from what I have seen virtio-v4l2 can cover
> everything that the currently published driver does (I could not find
> a specification, but please point me to it if it exists), so there
> would be no conflict to resolve.
>
> V4L2 with requests support should be capable of handling complex
> camera configurations, but the effort indeed seems to have switched to
> KCAM when it comes to supporting complex native cameras natively. That
> being said:
>
> * KCAM is not merged yet, is probably not going to be for some time
> (https://lwn.net/Articles/904776/), and we don't know how we can
> handle virtualization with it,
> * The fact that the camera is complex on the host does not mean that
> all that complexity needs to be exposed to the guest. I don't know how
> the camera folks want to manage this, but one can imagine that the
> host could expose a simpler model for the virtual camera, with only
> the required knobs, while the host takes care of doing all the complex
> configuration.
> * The counter argument can be made that simple camera devices do not
> need a complex virtualization solution, so one can also invoke
> simplicity here to advocate for virtio-v4l2.
>
> My point is not to say that all other camera virtualization efforts
> should be abandoned - if indeed there is a need for something more
> specific, then nothing prevents us from having a virtio-camera
> specification added. However, we are nowhere close to this at the
> moment, and right now there is no official solution for camera
> virtualization, so I see no reason to deny the opportunity to support
> simple camera devices since its cost would just be to add "and cameras
> device" in the paragraph of the spec that explains what devices are
> supported.

Well, for reasons described above it still seems perfectly fine to me to
have separate devices. Ok, the argument, that this approach also seems
more future-proof, is not a strong one.


>> 3. More specifically I can see, that around 95% V4L2 drivers use
>> videobuf2. This includes the current virtio-video driver. Bypassing the
>> V4L2 subsystem means that vb2 can't be used, right? In various
>> discussions vb2 popped up as a thing, that would be hard to avoid. What
>> do you think about this? How are you going to deal with various V4L2
>> memory types (V4L2_MEMORY_MMAP, V4L2_MEMORY_DMABUF, etc), for example?
>> I'll try to dive deeper myself too...
> VB2 is entirely avoided in the current driver, but my understanding is
> that its helpers could be used if needed.
>
> In virtio-v4l2, MMAP means that the host is responsible for managing
> the buffers, so vb2 is entirely avoided. USERPTR means the guest
> passes a SG list of guest physical addresses as mapping memory. VB2
> may or may not be involved in managing this memory, but most likely
> not if that memory comes from the guest userspace. DMABUF means the
> guest passes a virtio object as the backing memory of the buffer.
> There again there is no particular management to be done on the guest
> side.
>
> I bypassed VB2 for the current driver, and the cost of doing this is
> that I had to write my own mmap() function.

The cost of it as of now is also that:

1. Only guest user-space applications, that use V4L2_MEMORY_MMAP, are
supported AFAIU.
2. There is no flexibility to choose whatever way of memory management
host and guest would like to use. Now the guest user-space application
selects this.

The latter makes the solution much less flexible IMO. For example, this
won't work well with our hypervisor. There might other special needs in
other use-cases. Like sharing these object UUIDs. Probably this can
handled by mapping, for example, V4L2_MEMORY_USERPTR to guest-pages
sharing, V4L2_MEMORY_DMABUF to the UUIDs (which is not quite correct
IMHO). So this already means querying the device for supported sharing
methods, rewriting the flow of V4L2 UAPI calls on the fly, ensuring
consistency, etc. This already looks hackish to me. Do you have a better
plan? Also this limits us to only 3 methods, right? And what if there
are more than 3 methods in the future?

I think this inflexibility is a major problem with this approach.


>>> Actually I don't think this is even something we need to think about -
>>> in its simplest form the V4L2 guest driver just needs to act as a
>>> proxy for the device. So which decoder API is used by the host is
>>> completely irrelevant to the guest driver - it can support a decoder,
>>> an encoder, or a camera - it doesn't even need to be aware of what
>>> kind of device it is exposing and that simplicity is another thing
>>> that I like with this design.
>> As I wrote above the design would be indeed simple only in case the
>> actual hardware is exposed to a backend through V4L2 too. Otherwise the
>> complexity is just moved to backends.
> Yes, and while I acknowledge that, this is not really more complex
> that what you would have to do with a virtio-video device which also
> needs to manage its own state and drive the hardware through backends.
> I say that based on the experience working on the virtio-video device
> in crosvm which follows that design too.

As I wrote above we have a different use-case. And I see the current
state of virtio video as a good common ground for different parties and
use-cases. Unfortunately I don't see any upsides for our use-cases from
the V4L2 UAPI proposal, only downsides.


>>> This simplicity goes away if the guest device does not use V4L2 as its
>>> user-space interface (e.g. Windows?). In this case we would be in the
>>> exact same scenario as the current virtio-video spec, where we need to
>>> build device-specific structures from the guest driver's internal
>>> state.
>> IMO this is not quite correct. The scenario would not be not the same,
>> because the V4L2 stateful decoder API is more complex in comparison to
>> any virtio-video spec draft version. Probably it would be great to have
>> a list of differences. I hope to find some time for this later...
> There is not much difference between the V4L2 stateful decoder spec
> and the virtio-video spec. Actually that's the very reason why I am
> proposing to just virtualize V4L2, we were redoing the same thing.
>
> I have quickly parsed the V4L2 decoder spec and here are the
> differences I have found:
>
> * VIDIOC_STREAMON needs to be called on both queues to start decoding.
> * Frame crop is obtained using VIDIOC_G_SELECTION instead of being
> available alongside the format parameter.
> * End of drain requires to send the V4L2_DEC_CMD_START and call
> VIDIOC_STREAMON again.
> * Seeking is done by calling VIDIOC_STREAMOFF followed by
> VIDIOC_STREAMON on the OUTPUT queue instead of having a dedicated
> command.
>
> ... and that's basically it! Do we really need a new spec just to
> smoothen these differences?

If we look deeper there are more differences. I'm still preparing the
list. Sorry, it takes time.


> I hope I have somehow addressed your points. The main point here is to
> discuss whether the V4L2 UAPI is a suitable transport for guest/host
> accelerated codec work, regardless of what the guest or host
> ultimately uses as UAPI. The goal of the PoC is to demonstrate that
> this is a viable solution. This PoC is largely simplified by the fact
> that V4L2 is used all along the way, but this is irrelevant - yes,
> actual devices will likely talk to other APIs and maintain more state,
> like a virtio-video device would do. What I want to demonstrate is
> that we can send encoding work and receive a valid stream, and that it
> is not costly, and only marginally more complex than our virtio-video
> spec attempts.
>
> ... and we can support cameras too, but that's just a convenient
> side-effect, not the ultimate solution to the camera virtualization
> problem (that's for the camera folks to decide).

Thanks for your answer!


>   Cheers,
> Alex.

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

