Return-Path: <virtio-dev-return-12453-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6FAC77B73
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 15:12:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D321C77E9
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 15:12:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B89A6986652
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 15:12:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A3E9D986644; Thu, 27 Apr 2023 15:12:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 931C9986646
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Apr 2023 15:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682608368.830000
X-TM-MAIL-UUID: cb192805-1ffb-44b9-90d0-adee1219e406
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlX5xr627M/3BQISRAO/O6VBmoa++yMOG7suQrMiIi2SYJwzxI6gPBFhmHcD5+DtA5hurZ0pwKDo2pTZjp6O0yKpi6B27xZwV/U7/yH6u7lB3IJXkPTMFqcw+TKqV7iKuWsfZafT3X0Btd+z4gqk8we5TNtZsZ1N59oS1z58vf5v9r+5dSJ6bKlVlaAFWmtpXrJLRy19ZWdqgyqWBO4ZEVgqHwBVFiNPTujfQGEJsm6KUH/RQclLfMP7wVKjBOjFjufaLLtHSibl7cDjRJKmmM6Sh6aWcJmcwT3GGy8peO+PyjNF1fErwsYm5uzyPsmk8wVYjigXdb8NdQj6IjzYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0ZI4eyLF6QYr3TM9GfPGhJxCGMr8xMVnJL6sOX3ppE=;
 b=CFPfPRWmCiVx+B04uOIOdXnN3Hu2Rf0TC7r/OGKW5115ODHMEvvjXpj6hGejsbsH4ILA7//IHGoIVdi09+YzDjE5og2dVeZGtgeUhTkq7UHNzmOkdOciS0fAjDZ1/+41Ng8WwOq5Vy8rnVWZnKULNfgg1mVCqBXzeMStQ5HpTnWSnhWXThFHUGa9I7KNTedcgKbOtoIMTPrExRPjVeYXRi3q6bPESy9Sz43CI6ASW9vAERm8a5XADDUvhFN8RkksFwWgu6PqdkVHoCNqrwBAx2ObAhqztqIRWatCunQ3J15jdqWOGbIVcqs3v1iQUo7WDZ2pkDZYZF8+tkNLBGYPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <4fe9b619-c2b3-fe22-d7ac-b92ffc90a80e@opensynergy.com>
Date: Thu, 27 Apr 2023 17:12:46 +0200
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
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
 <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <630ba79d-aed7-60fb-b7b3-cb1d08b1073c@opensynergy.com>
 <CAPBb6MVWaBHR-d6aqaMXTxuX5ns3RNY4cNJhak5ijoicfTvoAw@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MVWaBHR-d6aqaMXTxuX5ns3RNY4cNJhak5ijoicfTvoAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::18) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR2P281MB1461:EE_
X-MS-Office365-Filtering-Correlation-Id: 246d1672-5b5c-4949-e22f-08db4731dc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kOl56vHQ8xTDOuF1QphioojEbax3UhRV3yTPdMQOSxASXZlurSmmS3+3HLnlS6UZ6oNysmXPAA1g97ZRL6e9jTMpUK185g9Dw5IcNROAjT01B34OZx960wAVvtP/lblel8E87TCe6RNHszDAaRQZGr8L7repSnTLHkZ/1xEpLPsv1npcFnrPsW0L5z56MCjkgiLnCbCZMHx4JnXDV434CYpA7w67IwlnXFiqSCQfZYxM4vNbPTkEyeXwNKq3uXeHNVUBMTVAJtJFmtkq1Jvck0naxFPt2OE538AMw4MJkj1m/3HFPCs+HL6cNeO7r7i074uLU37ZLjwZyv6YSOg6aeg0RJpeX1O+ja2iL3GdnAcSq+1ZZu6TG/9YzaxIcMC628+0A7tvl5OWv0A/hX7s3tsQryhjWmnKMkWSU5LkFbty62//pWrpXHL7L+CpDRik1g5uQYiA3GSHudY18Gm5slM2W9ins7qNElc1MsqFTrymOxemf2LDH82gAmV2rGS2iWiDD+NcTxHmMIOIhI/zOUgF9kb9CzAkAKKrQW2YJgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(366004)(136003)(346002)(396003)(376002)(451199021)(38100700002)(66476007)(478600001)(42186006)(66946007)(66556008)(54906003)(66899021)(6916009)(86362001)(5660300002)(2906002)(44832011)(8676002)(8936002)(7416002)(316002)(4326008)(41300700001)(31696002)(26005)(53546011)(36756003)(2616005)(31686004)(66574015)(83380400001)(186003)(15974865002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3o5ZS8yd2d4SElYK2tWd0xWUmFhZzFVZVI5dUNCKzlTSWwveDJZZlQzSzRR?=
 =?utf-8?B?NTYrZjl3UmtpenBkdWV6ekdRUzdQb2kyQlF0M1hzSzM0TnlUMzBRRU1sc25w?=
 =?utf-8?B?ZmRVRU5vaUZlYVYrVTArK3RyMFRlSHdiN0xVR1lOWXdsRzZwYmYrRTdCd2xN?=
 =?utf-8?B?YnNIQW9vdTVkWjRWRnFycFJ1VncyemtaUWxyWVd5UmhzQ2MrMWpJU2RCeHdN?=
 =?utf-8?B?SFF5MHYwOFM2bDBHdDhwLzM4UXZZam00OTlaNFhDLytYODJtYUtCTVRDd3lh?=
 =?utf-8?B?c3E5NUNDejRTRE9BY2FOWDVHNzZzS3RQbVZQdlozUlFQdnVRWHVib215M25T?=
 =?utf-8?B?eHFtcmZjaTB5c3pGSDdGZTdYbHE4L0hPZmFOWFVtb283VVFxc0txbHRqOUVU?=
 =?utf-8?B?NzNTaEcwZ3hBVHR0VGdTTjZMcm5tK3dBNlFCeDlva1hjUVBvNEcvWlhya29r?=
 =?utf-8?B?QVJOOGJNQ2lmS2M5azZFOHFlNWdMOG45SVY4VUV5SGFmUUNTcEdmcTRGbW92?=
 =?utf-8?B?dkdINlJLRE5NcnFOM2hMUjZLRGVCQjJGbnZGLy9LdCt6bG40bTlBcVArbjUy?=
 =?utf-8?B?YTJHcm1TWWNBUytUamZvU1hmRGlxbi9Kak9DeUp2TG15eC9lblloc3M3LzI2?=
 =?utf-8?B?ekNvNFN2WHBMRnA1azFoTlFuOFFnanVKa0hxT0tYOWpkZThHWTdiRG9OUnJ4?=
 =?utf-8?B?QVJnM0ZIMWVIeG41bmRXK0Y2dW9pdWZtcU1RYTVaUnhBdm1weWxvU2ljb2gz?=
 =?utf-8?B?SXBVYk52RlgzZzhsTGIyMUhJOWZvQVhLYytZR0NwbTgzRkpIRTYxS1N0RUdB?=
 =?utf-8?B?K2pFWW1TY1lKdUJhelI5MVl5ZkZ6TWdFNThkZnpMOXFPbkFNS3lZQ0phTlF3?=
 =?utf-8?B?WWdKcUhjVHJDWHFkanpmSWpSSE5XcDJ1Y1ViTkFWa0MzRFQwYXRLbjgzQzFV?=
 =?utf-8?B?REZydXNXN0tvSHhiSSsyS21CNjAzMzBEOFprRVRlZSszekFCK1Zoa21oaEdz?=
 =?utf-8?B?ZWpBNGpFMVdDQkhJamNnVGxNRGZIdFhzUUtUUFY0NGRyVGRUZ3ZLUFk2NUxE?=
 =?utf-8?B?YUFQQWRjRkR0U0ZkdlQzZW5DbXYva2pzSGZRN3Z3eFhPUVJGU3I1ZnhDaURl?=
 =?utf-8?B?d1hlemYrM2w4WjJ6OXR6M0tuNVkreW15M2Jwa1dEbUNPZW5QdlhsWDlWSXVT?=
 =?utf-8?B?K0tROXN4T00wOGlGS1RNekhrVnloSlFNeEdiaFpxY3puUnFPczdsZHUxdkFU?=
 =?utf-8?B?ZzBVTEQ4T0s2d2I5cHVvOXpuL1pJZzU1VXdaTUZtejZlS3NvbUpmUmFvdi9D?=
 =?utf-8?B?ZmZkS0JWc0JyL3pkMUljS2lxTE5pTG91ODFwSWFXTmVxOVRoU2Rob1lKemN2?=
 =?utf-8?B?UklMQlY0eE5WN08ySU9TN1dob21Ublg2N0VINXA2cjVBMjRxcmZCdVdadGJB?=
 =?utf-8?B?Y3pYZDB5ZkhPOHZxdzlyWS9nY3hWRHBTZDFhVkliVDF2SGJCV0FOWjVoczVG?=
 =?utf-8?B?NkYvNFBxTTQ2V1oxRnVhVUJaN2JGZ2o4WmdkeTRWQkdtRkoxTmlEVER3MndS?=
 =?utf-8?B?NGpTL1pWTk1tVlFxci9FTWlmQVV1V1JhVHlRektqdTJmQmszMkh1V0dUSVpy?=
 =?utf-8?B?RERHU0ozcnF6OW40V1Zaem0yOS9yZEtheWprOXFzMjVXNURzTVprZUZUMnEv?=
 =?utf-8?B?aGFhekFZN3laUkVKMGkwSWJSLzdBdnN3RFdqWVFCOXdVUGsyeHFhcjBjSmh5?=
 =?utf-8?B?TWdoSkMvNHRGdmh6RC9TQzUrbUVxMXVwKzNBa2szRmVkTUJBa0NVTE0wMWlu?=
 =?utf-8?B?RlMyc3JrQ1ZDZSsxSVJVUzBNeDNUL2UvM1piZlFLVGJuU09keGc1TUN3SCt0?=
 =?utf-8?B?TmJUMGlRWUxHMmhHQnlSY3AzNnpmZGdlaHhmU24vcS94NjF5eFVqa3R3eC9M?=
 =?utf-8?B?MzYwckFhMGE3MG80RTB0VVdKSm5PTVdqZjJrNGF2aVNSa3BPZlNuYU9Yc1Qx?=
 =?utf-8?B?c3FsMVFvTVQxS0RJZHdDaTd6YVpHNlM5RUpqVGoydVBJcmN5dlJYZGRqVUVZ?=
 =?utf-8?B?ekZqMEduY1llclZRNWZyWWdSd0xIKzlCUTRSeGNKTStaZUhCY1dXMVIyR2lo?=
 =?utf-8?Q?pxWeRO18kUKH45WAE7KdXErQ6?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246d1672-5b5c-4949-e22f-08db4731dc0a
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:12:47.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVn7I1H8QFiWkMEOD+vlysoZWaT94ueFlkk32RqaYgRREN/1w023ZGXWFPlh6SqzO7sWtitn64oSlEwx5xmdDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1461
X-TM-AS-ERS: 104.47.7.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27592.000
X-TMASE-Result: 10--24.354600-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFr/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QdRXC4cX65cJBpl
	bnRIZ6aEDEt2jZXyR94s9BFpCoO/Ggy/yIc8KCC1EclbAMYYY6xMVCcj56k8hk65GLp8xzq7TO2
	Wj/eDsovkHA/+hZGdqXME66DP9iSaQd6ggaZlaf4LwUwfdPoXvk0s9CXRACW0xwRkdFskKgJKKQ
	/kQgkQZHlQi+AGQkPaz26dfepJpeO7SeMg4Xshgf9XRIMLUOjQHFZ70WvsP0aBC3MCELqzqMqbf
	FkwjxPoUOwMcoKcjpU1aRRWbFH55X+zsg6kp2C3Be3KRVyu+k3DBQ4zH7+5AxwazRJ4X53TloL8
	pJlLj8r065Uzs3WWb5LYGbA6dvE/mUrbKPK/q2fTzWmGCXkX+U4Z9+xRT+QNDpCUEeEFm7AZIQo
	SDur4PIobvaBH3ARAsgYH3sKr6X10tMeOizCSGgmyVrMCuJ9S1KDIlODIu+WCCtUaLksF8Nh7sO
	tYy7MA7jUA7Y9PwrRCNEei2kg1tCxLHUodmiaU6oMqSPTYRnUpmgrUX87USR8gYJm5tOzE4+GzX
	v33W9E5zvpUzPwJH0mGaB8YoJ2mw1p3W0wlPxfece0aRiX9Wrrbdg3IehXKRLQWlsj7XhOcOnLq
	T+WCfd6g++1yrRzk7LFneq9M+d8lO3FWVopgWxHdIZ6edcbrAvr1/Yq4GSQ0IZYLx2FhKG2dQgG
	cmWnU7mqp3eYkKzgxxt66gKYZILOSuzNaqOKl4yhsfWHTXOKhHrZE2+S86+KYpwtG+wHVZJRY4M
	A0GSr9c56RbPBO0g7bzkYcT4NQRrRi+2YO9Y5+yskgwrfsC30tCKdnhB581B0Hk1Q1KyJHtBsf5
	/UXJbVQu1GNZ+sikGUtrowrXLg=
X-TMASE-XGENCLOUD: a3e601f3-e08c-4e3a-8ff2-c0c3effa6de1-0-0-200-0
X-TM-Deliver-Signature: E05FB655BFB0965042F695C17C4B7670
X-TM-Addin-Auth: ids7lF9yhY3GvwHuq6Mlkp6RRnExYzdToblOgWKKui9LVtPVZQNthpoftsi
	xNnZN/nKOucSV6mbxNiwT12X2cyWM9O1xu36BOnAV1FmzwvovkO/2CtIzKln2K63cQVFklugw3c
	fC4Bo2HmFhM3a3qC+vIMeH0XTJtJr+3+VsLQUiE7ErReF6HZYU9SAhTdgFD9X/gu/br7DL0qHok
	w/gI7N0eZ+2AjladkVkh2Mwy65dSWARy+xmdZRB0HJffmwRPxx6reoFRUVZOeX+yr3a9K9VlI8P
	0y+Usr5/eJ2hQek=.f4lBUQVeJr1kP8ldru94kHqZjsFRMpZ4qeMiPNYnHVpWgllA9vMLUd+oVn
	IfWozpPupGsprrdJ5jRYKaaxYTRhNdMKQSbwWk3k/YYFObpTpG6h0BwUFHKt+SvS/HlNuMMDNxp
	bilgXt+Bg9pX+0XKRh26EGprWWhYX4RgD5XqLOUiq1BTDYjlh47Lr0sKghfcJNZRHtr9xz+5NBu
	pu63uE99Vb0xa5o07xtNK4ZW/M0lomglUiZlyRC0Q86XoxV+mgwi38Bq9qAzZa5P1/BG3iLLOSL
	8TohlSArZNcnBkXYYoAQKPWDfa6lmRLKYTh061h2tNDHe38YwyX9q/XLHZg==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 27.04.23 15:23, Alexandre Courbot wrote:
> On Thu, Apr 27, 2023 at 12:52=E2=80=AFAM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 21.04.23 06:02, Alexandre Courbot wrote:
>>> On Wed, Apr 19, 2023 at 4:39=E2=80=AFPM Alexander Gordeev
>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>
>>>> On 17.04.23 16:43, Cornelia Huck wrote:
>>>>> On Mon, Apr 17 2023, Alexander Gordeev <alexander.gordeev@opensynergy=
.com> wrote:
>>>>>
>>>>>> OpenSynergy, the company that I work for, develops a proprietary
>>>>>> hypervisor called COQOS mainly for automotive and aerospace domains.=
 We
>>>>>> have our proprietary device implementations, but overall our goal is=
 to
>>>>>> bring open standards into these quite closed domains and we're betti=
ng
>>>>>> big on virtio. The idea is to run safety-critical functions like coc=
kpit
>>>>>> controller alongside with multimedia stuff in different VMs on the s=
ame
>>>>>> physical board. Right now they have it on separate physical devices.=
 So
>>>>>> they already have maximum isolation. And we're trying to make this
>>>>>> equally safe on a single board. The benefit is the reduced costs and
>>>>>> some additional features. Of course, we also need features here, but=
 at
>>>>>> the same time security and ease of certification are among the top o=
f
>>>>>> our priorities. Nobody wants cars or planes to have security problem=
s,
>>>>>> right? Also nobody really needs DVB and even more exotic devices in =
cars
>>>>>> and planes AFAIK.
>>>>>>
>>>>>> For the above mentioned reasons our COQOS hypervisor is running on b=
are
>>>>>> metal. Also memory management for the guests is mostly static. It is
>>>>>> possible to make a shared memory region between a device and a drive=
r
>>>>>> managed by device in advance. But definitely no mapping of random ho=
st
>>>>>> pages on the fly is supported.
>>>>>>
>>>>>> AFAIU crosvm is about making Chrome OS more secure by putting every =
app
>>>>>> in its own virtualized environment, right? Both the host and guest a=
re
>>>>>> linux. In this case I totally understand why V4L2 UAPI pass-through
>>>>>> feels like a right move. I guess, you'd like to make the switch to
>>>>>> virtualized apps as seemless as possible for your users. If they can=
't
>>>>>> use their DVBs anymore, they complain. And adding the virtualization
>>>>>> makes the whole thing more secure anyway. So I understand the desire=
 to
>>>>>> have the range of supported devices as broad as possible. It is also
>>>>>> understandable that priorities are different with desktop
>>>>>> virtualization. Also I'm not trying to diminish the great work, that=
 you
>>>>>> have done. It is just that from my perspective this looks like a ste=
p in
>>>>>> the wrong direction because of the mentioned concerns. So I'm going =
to
>>>>>> continue being a skeptic here, sorry.
>>>>>>
>>>>>> Of course, I don't expect that you continue working on the old appro=
ach
>>>>>> now as you have put that many efforts into the V4L2 UAPI pass-throug=
h.
>>>>>> So I think it is best to do the evolutionary changes in scope of vir=
tio
>>>>>> video device specification, and create a new device specification
>>>>>> (virtio-v4l2 ?) for the revolutionary changes. Then I'd be glad to
>>>>>> continue the virtio-video development. In fact I already started mak=
ing
>>>>>> draft v7 of the spec according to the comments. I hope it will be re=
ady
>>>>>> for review soon.
>>>>>>
>>>>>> I hope this approach will also help fix issues with virtio-video spe=
c
>>>>>> and driver development misalignment as well as V4L2 compliance issue=
s
>>>>>> with the driver. I believe the problems were caused partly by poor
>>>>>> communication between us and by misalignment of our development cycl=
es,
>>>>>> not by the driver complexity.
>>>>>>
>>>>>> So in my opinion it is OK to have different specs with overlapping
>>>>>> functionality for some time. My only concern is if this would be
>>>>>> accepted by the community and the committee. How the things usually =
go
>>>>>> here: preferring features and tolerating possible security issues or=
 the
>>>>>> other way around? Also how acceptable is having linux-specific proto=
cols
>>>>>> at all?
>>>>> My main question is: What would be something that we can merge as a
>>>>> spec, that would either cover the different use cases already, or tha=
t
>>>>> could be easily extended to cover the use cases it does not handle
>>>>> initially?
>>>>>
>>>>> For example, can some of the features that would be useful in crosvm =
be
>>>>> tucked behind some feature bit(s), so that the more restricted COQOS
>>>>> hypervisor would simply not offer them? (Two feature bits covering tw=
o
>>>>> different mechanisms, like the current approach and the v4l2 approach=
,
>>>>> would also be good, as long as there's enough common ground between t=
he
>>>>> two.)
>>>>>
>>>>> If a staged approach (adding features controled by feature bits) woul=
d
>>>>> be possible, that would be my preferred way to do it.
>>>>
>>>> Hmm, I see several ways how we can use the feature flags:
>>>> 1. Basically making two feature flags: one for the current video spec
>>>> and one for the V4L2 UAPI pass through. Kind of the same as having two
>>>> different specs, but within one device. Not sure which way is better.
>>>> Probably having two separate devices would be easier to review and mer=
ge.
>>>
>>> Having two different devices with their own IDs would indeed be less
>>> confusing than using feature bits.
>>>
>>> That being said, the whole point of proposing virtio-v4l2 is to end up
>>> with *less* specification, not more. Having two concurrent and largely
>>> overlapping approaches will result in fragmentation and duplicated
>>> work, so my suggestion would be to decide on one or the other and
>>> stick to it.
>>
>> Hmm, Enrico pointed out, that having virtio-v4l2 would also be good
>> because of much better compatibility with Android right now. I don't
>> think the specification length should be our ultimate goal. Cornelia
>> said, that her ultimate goal is to have a spec everyone is happy with,
>> regardless on how we arrive there. Well, I can only say, that I also
>> think this should be our goal.
>
> Try to put yourself into the shoes of someone who needs to write a new
> video device using virtio. Oh, there are two ways to do it. This guest
> OS only supports virtio-video. But this guest OS only supports
> virtio-v4l2. Great, now you need to support two interfaces with your
> device, or write two different devices.

I think this is a hypothetical issue. IMO it makes sense to use V4L2
UAPI only on Linux host with V4L2 devices + Linux/Android guest.
virtio-video driver is already available for Linux. We already know our
priorities and limitations, so building a decision tree for a potential
device developer would be very easy.

>>> * Having two overlapping specifications for video is overkill and will
>>> just fragment virtio (as tempting as it is, I won't link to XKCD). I
>>> strongly advise against that.
>>
>> I think they're not going to create more problems, than virtio-blk,
>> virtio-scsi and virtio-fs, for example.
>
> At least these devices work at different layers, that makes them more
> justifiable. virtio-video and virtio-v4l2 are just going to provide
> the same API for video devices, only with different structures and
> commands.

Hmm, I think virtio-blk and virtio-scsi work on the same level, aren't
they? They could also say this is basically the same thing.

>> The decision can be made like this:
>> 1. You have a V4L2 device, you don't need any more processing, just want
>> it inside a Linux/Android VM =3D> use virtio-v4l2.
>> 2. You don't have a V4L2 device, or your host is not Linux, or your
>> maybe your guest is not Linux/Android, or you want some extra processing
>> on the host (say you have a third-party proprietary library or whatever)
>> =3D> use virtio-video.
>
> That would make sense if 2. could not be done just as easily by also
> using virtio-v4l2, which I believe it can be.

I'm sorry, I think a potential developer would just look into V4L2 docs,
see struct v4l2_buffer (AFAIU with patches in the spec for the
host/guest/object memory types on top) and run back to the cleanliness
and simplicity of virtio-video. That's basically my story. :)
Iterating on formats in VIDIOC_ENUM_FMT looks quite weird to me too.
Thankfully this is not a big deal usually.
Also it depends on the use-case of a potential developer. If the
priority is on security, if they only need decoding/encoding video or not.

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

