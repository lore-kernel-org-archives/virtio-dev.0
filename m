Return-Path: <virtio-dev-return-12644-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8315AC7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 08:50:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A0AB526A2B
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 08:50:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87EC79865E1
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 08:50:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7113B983E4E; Thu, 11 May 2023 08:50:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E3F59865CE
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 May 2023 08:50:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1683795022.646000
X-TM-MAIL-UUID: d0cb7912-0c03-4afe-9598-6cab00ae716d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRdzRNRWQ9aZ4sC/jOEMuRL2Rdkjpqvmj9jFDv3LliDuNGS6Tqrc6SZdNUiS9Q79U+1DVf+FYa8mwgQ/058fqqQWo+EuaXyDI8Dst0vnAYKocmrIidRxrDU+CZKk1ZYAkIVuuB8F/zADI11XzHzAlyQWA7GHnFI4j+KgYAkCx6CApuGI/8hWTUvW7HOdupZ1fccRro6IyAvxVFKv5SzuuON739b3sqlhplWNJ2UZF0F6XWGWN+t9cIpVoUxbm/CMeAinwKtAw2CtKTNyMe6wH8XG+neIlQy2ucQ6jtgc0PbQDl11+qmWGncnwpbQ9LWyGxmoTtIQo/swr8auvAPDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFkxaRSQ2a8fFt/jDOpqZufO3DxD+Mb5fOF8tXd+ZpQ=;
 b=TKNEdFKMm8jpEwcYbn0wrBsh1/B+ORVb0gkgKGg1ypEhwYgD7w/4Wgy9P8qB6lqCyIA3OEN6OmeA8yMLuYlnsEcyRfPf2/ZdVgzIwQ/oUexSDs/VXvLvSks75doPOcQNNmTWXp5I7nopWovfAIeYKEp58qUEvjVYiwUknOBmL+bwiUHngiY1VADB9l52YKbYHWlzDDDSLIgCwkNWsPdCF3QbOPIddSJdCVG37e5lOG2JYWBZOwAIrPr6mZf5ATq3OlfeXXpA2Uvo31d3PmWKUbMpYmnR4L69V08rEwo3IPdnNRa4LGnjmOXI5UAJwgbgZwTKr0BVT8Rq04nT2kkUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
Date: Thu, 11 May 2023 10:50:16 +0200
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
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
 <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
 <87a5ylzf34.fsf@redhat.com>
 <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com>
 <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::17) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR2P281MB2687:EE_
X-MS-Office365-Filtering-Correlation-Id: caae680e-d9a9-4737-d91a-08db51fcc0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WKgyAl1wg6vHYihzNUxNABYzUh+C+WM7TU2FuxbBfArdv5pyUABEnThiacMiaenVJvx+xUOjeOp2p8KvcbBIkg7uWvm6XTBOgJwm6rad1VR/4wMf7joC5itu15EMoTS3uBqbp21HwANpHaocD3V2rsTBiMvCz255ftqcx4zIXnt048o2mPVlqxW3R172wFv8zA92HyUC6oGTUBVk5R2h4sHlZEEAn2KRF6cXehazSYmojqmHjWeqNwIYCnFSUbyvmKUlmp4xb8VuzMvjqAdBq6w4uDTZfzzyJkGwasSc2N3iG0coA5LfXAFxupTL8luNrSRBo57vwCboa3rMxKAR3OlOD6lfqz8dwYk/+1mBaD4QFKvarq23q5BoGongZdlmNwwNC8Jkex106NfkkNGUEYDqoCTo1JhEkK6z0DoWWcxY9RhBT6g4Qx0G4LKDuesdqgkS5lX1Ql5OJVP3ILnDIcXaRn8AeVPkyRZsHojNT3vOAvKqKgiROM+x+3COYEiPYxIUuEdfILUb1jV5XXyhf9pnSCOOrOJBWnZRkeh2+X6qerh82nL3HIkQHU69q20LcdAeXiyIXRvsGkGmDpfJRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(346002)(366004)(136003)(396003)(376002)(451199021)(38100700002)(15974865002)(186003)(26005)(66574015)(53546011)(2616005)(83380400001)(36756003)(966005)(66556008)(66946007)(66476007)(316002)(6916009)(2906002)(4326008)(7416002)(8936002)(31696002)(44832011)(8676002)(41300700001)(5660300002)(31686004)(86362001)(42186006)(54906003)(66899021)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU5obm9QZ3RkZ01xVU04RzFvejRoYXdYWXRnRGhDT1VXNGVSOFBsa0VrdFlk?=
 =?utf-8?B?MFN3YXBYa3JVdFM3K3BjSHllS2FweVZBemk3YjFPd1hvQ012L3RhTmd1Z0c4?=
 =?utf-8?B?U29DN296ajVPdDFadkNBK0hLbW5nM2NhVlRiTWtneXIxdnBSdUVmQ05kZUx4?=
 =?utf-8?B?WXlFNEFQTUtQWFgwTytsbkhQWjRvaDkvOHk1SytFOXkzQVgrZE4yeVBjWi9z?=
 =?utf-8?B?SWJyZEwrVkkrRU9sQ1h5bUdmRzBsdXIxelZsMkVjb1laSCtnWlJSdHRCVXNo?=
 =?utf-8?B?QlY0c1hQL1FZdTl2aVdGdVRHcEZKYnhLUGdHYld3OEEyM0ZwSDRVbDVpc2pP?=
 =?utf-8?B?T0M0NkM2Wk5EdURETEx6RkpSU2FIenl1MUpoQ0tUZi91bGJlSFZvMm9ZbkFr?=
 =?utf-8?B?NW1EcjdCeEVyRlRUU1dLdlkwUUY5cnJMa3JycDd4RGdnSDJpcWhwK3lXeUNL?=
 =?utf-8?B?dVN0UTBrMUx3bkxpS3ZoVjRFeHlXS094QzcxemI4dFkzWHFoUGtKWlZzMSsz?=
 =?utf-8?B?OThyeWoyTUR3cWl2dUV3VXI2eWZZNk8yTlE2SjR4U0VoUi84dU43TmxkN0dB?=
 =?utf-8?B?Y3VrWVBpMXdMRzQwaHBsOTR6WEc0UFNkbVA2WVh5V0JTaE9nQ29XZ25MNFNt?=
 =?utf-8?B?YmhETEFJV2QxZk1hS3ZDbUFaTVlmVGJPd0VrdzNOam9KMU9lQUhYOG5mV1ls?=
 =?utf-8?B?ak1vdTI1aWZiVWNQN05nbHJWaFI3Qi9MNkZjczlCbzM1MmttWnJnZjc4aGRp?=
 =?utf-8?B?ZnN5U0Y3eC8yTjQ1UjJmaHZOZXA2U2pDTmRzU28yRkIzNXlPZWhrWjhvbzlH?=
 =?utf-8?B?RW8wZjgyRU5CZmJRbVI4SGJ2bFIxK3hyRWU0MWxsQmw3cDltT0ZGemVHUUN5?=
 =?utf-8?B?YnhQRi9IL2ZicFpEdW45TlByN0tWbFpOL2hSaTFiNXpoT1cwaU5OM25raVlE?=
 =?utf-8?B?QldINHAydTJ1bWY0Q3YxdU8vRU5kM09hNzYydGMycWtPVWdZd05obEc4WnQ3?=
 =?utf-8?B?cHhBT0gxV0pmb09UUmdRQWZEai9yaVZOMWxjdVJUaGoxcWpoL2VvY2NYS1R4?=
 =?utf-8?B?VU1ZV2tXM2R5QS9lWnN6djYwbURtNjRjaDF5Tk9tVWh0RVFaTWtMem5NcUR1?=
 =?utf-8?B?N0l2dElBakQ3elBHVjlEUGw4YWRCNHZVZ3FuRkZpcngzTTJnQnYwRm9naHFa?=
 =?utf-8?B?dWRudzRtYnN4cTdsQUhLZWxwNytsODMvYjR5QjI2UWQxUklkM0FlcGYxT3A2?=
 =?utf-8?B?Q283ZCt3Zkg3Q1ZKdnFpMFBRWFQ2VG4wTWJoc2RtL2FHWTQyWlpuNnJHY3hT?=
 =?utf-8?B?RWNLVFFURGlTS25jVE1MamZuWEdoemsxUzhvSWNMTy90MU1OTjVNNkgyTUd2?=
 =?utf-8?B?Vmc2THFyTXhESlByOTlvbXNDMVF2VjNDQk5MMU1yTXpMNUdlTlFxbjYvdmFX?=
 =?utf-8?B?a1ZIYUFqR3dSTUNUNW93VW5hS2RzYmF0eEIvNXozTG9haDhRcHdqWG0rTllQ?=
 =?utf-8?B?SUEzTnJrdlVWQU5DMk15MW9makdrSjJ6VmN5cThJdzZIUDV1Q2x1MmZZdjVW?=
 =?utf-8?B?cUZtZGM3RjVjSnpFR2tHQnVCQzBCblZISDRXMjBkc3lrTXB1U3NteEU1VnV1?=
 =?utf-8?B?VVJaaDNtcTJ6S3ZaaE1WNXRabkZTdy8wZmFIeFA4Z2FaY1d4UUMwWmhzVkRm?=
 =?utf-8?B?YzYraEUwNEJqZnFHM1pOM3NQd1I0Vk9nMWhyMDl1dkQ4QnlkSCtqYTNhdTNu?=
 =?utf-8?B?aDNEVEVlZDB3cjVCZ0w3QU1VdHJ5aFlMa3dmUFNiVy9JYkZUM25MNU1VSko2?=
 =?utf-8?B?Z0R6UWtueUVDOGFsN01kbzl3eTdNNXJQQ05lTkJxSmxjV1c2ZGpxWUxoUVpo?=
 =?utf-8?B?a0hWcEpCZ0h2Y3hHbjB0enBFenpZVVZienRqN0U1U01MRGtPV3FLKy9CK2du?=
 =?utf-8?B?UnAxWGlldGNKcTFIWFJEcXhqWnh5MnhCeW5lSC9aV3pacVN1TG4vWFlZSTFx?=
 =?utf-8?B?OVlJZGdiRXBtcjlMTFJOWldqZVZ5b3BFRnpROXVvZlVKVHUzS0tZWTl5U3Vi?=
 =?utf-8?B?bzhiM2o3YmYrRTZWbW5MY3VqczVFOFg1WG84cVlIVzVqcVZzeDk4NUU4aXpR?=
 =?utf-8?Q?tuHyeyzcEjcLdeDNp06TOdBNN?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caae680e-d9a9-4737-d91a-08db51fcc0a4
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 08:50:21.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK/VlEBtFJJ6SeKaQFGzfFfJZOFlrvd+ekMsE2qWF26AFBlUcf0YGu9kRSONtSgpgcrKENbbFLLFavLkmXElrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2687
X-TM-AS-ERS: 104.47.11.171-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27618.006
X-TMASE-Result: 10--14.076500-4.000000
X-TMASE-MatchedRID: jFqw+1pFnMz/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYLK6
	GmKppGdqLVqxk9o1HBxAKEp+2HkEbv27vtwnQ39AIi5n/oIUxv+/KQGKQH1rQFAoBBK61BhcGDr
	P8zNo4TwMf7Ce+LIFds5yw/YC8uhnp1reWSY5Jcf0hv/rD7WVZKPLTdfaE15XQmw1cPfvj6maY/
	lzalOje6e76VC6sRoK8uypKo/12dOrofp7IohGwyhvVjkRcuKhAajW+EL+laOtBiS9hFeaTOfE4
	NGuUaNHfWrgQNsTIWqUI512D01p9G7lkbyMKxttFDuTLTe6zcMR5c83KIxTTjjG1ABBh6LlUYh+
	XbvSa0glqqWTemaW5INFhuChNKBZJBgtEIxUn4FOKksNozKUfTa6AaQm7fhmN2zK9lb+laYJtgc
	1847JRWrffv7+FREl3CoThJDYrJ3vXN3A3XXzVGgws6g0ewz2OBZxjY82VrgM74Nf6tTB9sWPCs
	f/4vHiFXs3Y/t01pPXOOuLrfYA/rOhM2gbEGogMIiU395I8H2623YNyHoVypzabk7e51x0t4u3o
	IKJmtGKhzwq031iGFfWYk6MdpYIdpUt2ByAf3ALuM9syeC5MDQYiBOWOsdtHW7srwepo1zkKJUT
	UX8T2wDujERjcOlmT5/SGqcZxAEL0MkR8StpMEgrYMYHLKzKfC0y8wDng2T1rmsJQmVJkIRMyN/
	ppM4nReC9ZA4xp+3sN8m7CGfYroAmZBFJUdK3/HTKStsDGMLOhLimqQauQ9VhYW3XBtfsSzCB6P
	yBOYHHyjn2xyeLrPB6rjHDtWztZMWKXMYF1HF+yskgwrfsC30tCKdnhB581B0Hk1Q1KyKh5DOWG
	PdqWY2j49Ftap9E4kYXbobxJbLyU/oX+tpNmPoLEnltozQnNSs8p+ns6KEPZHC7GDADOMYBwUfr
	04BcrHDkkx3Q+wxoBmTSwRxjXg==
X-TMASE-XGENCLOUD: a9311faf-be19-4cb4-a80c-353140a9498c-0-0-200-0
X-TM-Deliver-Signature: A852D676E36DB1A9955520F5E9D6C15D
X-TM-Addin-Auth: 8z8JH2SJo1ARESaRTKuadXr2zIgJElfeDt600cZeK9iEWe1k3VHWdeiAEIF
	4Fh/DwWODd3q9RUNjmKIzcdaTR56MVSLfUtiezniND2kVnXLulEGODmY5FIQeo24oYwjI9rsYEJ
	K34Pjhalh+Y5eIawXIsyiI7VaiMMhDx17ppyI8rnBwbPBK9PNR0szAkXRlNL6YPTAQP9x/5jGMg
	py9FZOcVeVa6wBzZ6Vyx5kQsp4igVfZCtBBCetpt3Bq9U2bag7UJvFUQhey70J7282jljO41w2+
	/W08Lo/KKb+4jrc=.PC9qAdSeoOYcG5kd08eGi6IRka0x/1rsPLDkZ2PamtADN/FArOtSyWApLr
	C5gCt+EQHav7Cb7houFALJVSaoRY3cLSVy2HQblck5doDrneq2keGsh+jNeuGryswEea2tuqmfg
	OCxZ7OOZU4KwQJVaz8ycfzXbu9lI7I+SxOjzej4hA7+DlM3kHWH+Rew+0kV50HauDoDA0Lw6O02
	YlDo/cBqp1oXNpOjtQb2KLZgk4mTecLDFpBYQuk2hkzZtO7nEHZTYrroiSzwYb+Q7ab3Ol3TUjX
	EO9dsMAD669crKhBhWfN21XNCWTvrt1anXjdcCyU07ew7r1TNMP1WfUP+cw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 08.05.23 06:55, Alexandre Courbot wrote:
> On Fri, May 5, 2023 at 8:55=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 03.05.23 16:04, Cornelia Huck wrote:
>>> On Fri, Apr 28 2023, Alexander Gordeev <alexander.gordeev@opensynergy.c=
om> wrote:
>>>
>>>> On 27.04.23 15:16, Alexandre Courbot wrote:
>>>>> But in any case, that's irrelevant to the guest-host interface, and I
>>>>> think a big part of the disagreement stems from the misconception tha=
t
>>>>> V4L2 absolutely needs to be used on either the guest or the host,
>>>>> which is absolutely not the case.
>>>>
>>>> I understand this, of course. I'm arguing, that it is harder to
>>>> implement it, get it straight and then maintain it over years. Also it
>>>> brings limitations, that sometimes can be workarounded in the virtio
>>>> spec, but this always comes at a cost of decreased readability and
>>>> increased complexity. Overall it looks clearly as a downgrade compared
>>>> to virtio-video for our use-case. And I believe it would be the same f=
or
>>>> every developer, that has to actually implement the spec, not just do
>>>> the pass through. So if we think of V4L2 UAPI pass through as a
>>>> compatibility device (which I believe it is), then it is fine to have
>>>> both and keep improving the virtio-video, including taking the best
>>>> ideas from the V4L2 and overall using it as a reference to make writin=
g
>>>> the driver simpler.
>>>
>>> Let me jump in here and ask another question:
>>>
>>> Imagine that, some years in the future, somebody wants to add a virtio
>>> device for handling video encoding/decoding to their hypervisor.
>>>
>>> Option 1: There are different devices to chose from. How is the person
>>> implementing this supposed to pick a device? They might have a narrow
>>> use case, where it is clear which of the devices is the one that needs =
to
>>> be supported; but they also might have multiple, diverse use cases, and
>>> end up needing to implement all of the devices.
>>
>> I think in this case virtio-v4l2 should be used as a compatibility
>> device exclusively. This means discouraging increasing its complexity
>> even more with more patches in the spec. virtio-video should eventually
>> cover all the use-cases of V4L2, so I think it is reasonable to use it
>> in both complex use-cases and in simple use-cases, where there is no
>> decoder/encoder V4L2 device on the host.
>>
>>> Option 2: There is one device with various optional features. The perso=
n
>>> implementing this can start off with a certain subset of features
>>> depending on their expected use cases, and add to it later, if needed;
>>> but the upfront complexity might be too high for specialized use cases.
>
> I don't see that many negociable features we can provide for a
> decoder/encoder device - at least not many that are not considered
> basic (like guest buffers). In terms of provided features for codecs
> virtio-video and virtio-v4l2 are essentially equivalent.

Actually I see a lot of potential in using the virtio feature flag
negotiation for virtio-video:

1. We already have some feature flags related to memory management.

2. I think it would be great to take V4L2 controls negotiation and turn
it into the feature flags negotiation. I really like this idea and I'd
like to implement it. Not all the controls at once, of course. Still it
would be very easy to port more given the existing process. They
correspond well enough to each other, I think. This way we don't need to
introduce something like the VIDIOC_QUERYCTRL/VIDIOC_QUERY_EXT_CTRL, we
don't need two mechanisms for feature negotiations (like it would be
with virtio-v4l2, right?), also all the features would be in one place.
Then we can directly reference some enums from V4L2, like
v4l2_mpeg_video_h264_profile or v4l2_mpeg_video_h264_level. That's what
I call taking the best from V4L2.

3. We can have things, that V4L2 doesn't support in their stateful UAPI.
For example, dequeuing output buffers in decoder order.

> The question is more: do we want a decoder/encoder specification and
> another one for cameras or do we want something that covers video
> devices in general. And is it desirable to reuse an already existing
> protocol for communication between a non-privileged entity and a
> privileged one (V4L2) or define our own?

Please note, that virtio-video could be extended to support everything
V4L2 does in the future. Including cameras if necessary. So it can cover
video devices in general too.

> About the latter point, Alex Benn=C3=A9e mentioned that it was difficult =
to
> find the engineering time to define virtio-camera. And virtio-video
> has also not been particularly fast to come together. virtio-v4l2
> basically serves us both on a plate for a lower effort.

If we talk only about codecs, the effort is lower only in case you have
V4L2 codecs on the host. Otherwise the effort seems higher.
I also hope to be able to update virtio-video at a faster pace. Please
let me try.
This is understandable, that working on the specs takes time. That's why
I'm all for making room for everybody to work. I think eventually
virtio-video or virtio-video + virtio-camera can replace virtio-v4l2. I
strongly believe this is a better solution for the long term.

>> In this case I'd prefer to have the simpler device first, that is the
>> current virtio-video, then to add features incrementally using feature
>> flags and taking into account the virtualization context. V4L2 is a
>> complex thing from a different context. They already tried to carve out
>> some of the use-cases like stateful decoder/encoder API, but this work
>> is not finished (struct v4l2_buffer can serve as an evidence). This is
>> like dissecting a monolith. Also it has to be patched to make it more
>> appropriate for virtualization (we can see this in Alexandre's PoC alrea=
dy).
>>
>>> Leaving concrete references to V4L2 out of the picture, we're currently
>>> trying to decide whether our future will be more like Option 1 or Optio=
n
>>> 2, with their respective trade-offs.
>>
>> I'd like to rely on opinions of people, who know more about virtio
>> development and goals. I would be happy to present or reiterate my
>> arguments to anyone interested if necessary.
>>
>>> I'm slightly biased towards Option 2; does it look feasible at all, or
>>> am I missing something essential here? (I had the impression that some
>>> previous confusion had been cleared up; apologies in advance if I'm
>>> misrepresenting things.)
>>
>> Indeed some of the previous confusion has been cleared up. But not the
>> key thing. Alexandre still claims, that this patched V4L2 UAPI pass
>> through is only marginally more complex, for example. I don't agree with
>> this and I have evidence. We haven't finished discussing this evidence.
>
> Are you talking about v4l2_buffer?
>
> https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/buffer.html#struct-v4=
l2-buffer
>
> I think you implied that some of its fields were not relevant for
> video decoding or encoding, which if you examine them is again
> incorrect. That also answers your question of why the stateful decoder
> spec did not mention the valid fields - because it is documented on
> this page, which tells exactly which fields the driver/device are
> expected to set for each queue.

I'm talking about struct v4l2_buffer, yes, but not only. Also about
struct v4l2_plane, enum v4l2_buf_type, the buffer flags, enum
v4l2_memory (but this one is comparable to virtio-video), timecodes.
For example, the way the fields in the struct v4l2_buffer and struct
v4l2_plane are filled and interpreted depends a lot on the type. Here is
the enum v4l2_buf_type:

enum v4l2_buf_type {
         V4L2_BUF_TYPE_VIDEO_CAPTURE        =3D 1,
         V4L2_BUF_TYPE_VIDEO_OUTPUT         =3D 2,
         V4L2_BUF_TYPE_VIDEO_OVERLAY        =3D 3,
         V4L2_BUF_TYPE_VBI_CAPTURE          =3D 4,
         V4L2_BUF_TYPE_VBI_OUTPUT           =3D 5,
         V4L2_BUF_TYPE_SLICED_VBI_CAPTURE   =3D 6,
         V4L2_BUF_TYPE_SLICED_VBI_OUTPUT    =3D 7,
         V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY =3D 8,
         V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE =3D 9,
         V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE  =3D 10,
         V4L2_BUF_TYPE_SDR_CAPTURE          =3D 11,
         V4L2_BUF_TYPE_SDR_OUTPUT           =3D 12,
         V4L2_BUF_TYPE_META_CAPTURE         =3D 13,
         V4L2_BUF_TYPE_META_OUTPUT          =3D 14,
         /* Deprecated, do not use */
         V4L2_BUF_TYPE_PRIVATE              =3D 0x80,
};

Of these 14 cases we only need 2 for the codecs. Right?
Also the flags. There are 22 of them. Are they all needed too? I don't
think so. We only have like 5 in virtio-video at the moment.

You posted code for filling v4l2_buffer in one of your previous emails.
What I'm trying to say is that a person, who doesn't know this in
advance, will have a hard time writing this same code if they only have
the virtio-v4l2 spec.

> Also I think I mentioned it before, but it would be really sweet if
> you could stop mischaracterizing virtio-v4l2 as a "passthrough" since
> it is very much not that, much like virgl and venus aren't either.

I try to use the "V4L2 passthrough" term only when I'm talking about the
actual pass through use-case like yours. Sorry if I misused it. I'll try
to be more careful.

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

