Return-Path: <virtio-dev-return-12751-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A55EC77B7D
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 06:29:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A728A2CAD7
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 06:29:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C8F8986702
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 06:29:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6CB069840C0; Thu, 18 May 2023 06:29:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5633D9866F7
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 May 2023 06:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1684391375.875000
X-TM-MAIL-UUID: 331b9fd7-ccf2-4d2f-8b17-ca273af8cd5a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTaCj5/+xoUw2U6YJIH94RFnj9VNkPVfxIXgU8qgntwOA+lQP0gfW5sp2D6isbzktY9729zzXzYIPVGzGD7qyaw8dguuUlH542xVOQLF/4k8F7pyg61/xRT4uQR387tHqGVyHpx2Hd/p6+B1BGRpWFq/izNWmp5+EVfx4WrjdUtIUrAsXFDoIphwuajTatJUBCFKKrEkmnulPSeTRoAQFMxzYSxS9OpwV/ZrAsZhAeOQN3ry4RAiWxXrte2quNjruWgc+jiy9uVbjoHetzE8TbVMguP9lOoGavL1WS9T85u4dkkLr0waCo+435SeQIFSRHhX8mpquCbLO7uIUjdMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHpWa2sSzRhz9LUgAP44zrQnjHaIGsrV/UQZRWtvmN4=;
 b=gC3947c1b5ehpBO16DxZDyY7xyB98WqZPwgda4Y8/QePJAb4Wq4IdgMSOkKPe1d/g/CqeUXiwLFFozVjYNg4xfqboj4DSxx/rZMVFI6U+sPStjagXWSgtdqhE3MxBwC6NpmDydEgjgiLRuEprSJhicnkL6JputuI00dkVjUa/kRNktRfkVgaI7tDEWIhHsy2PsyyH061++AZCxO0H7VjEVqmLWv/AIDsxho5hm7OSldMTjkwm28Jup0j5Q9yxRUiJ1+DtJGtuv48Sjh+UdU2MZd1hqjjKrH0G1TlXrBLpl7843YtjNL3+xlmz3nUi59D0s1NpPieX/Dxbcvfsx26xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <87f29e4d-5808-1ea5-ced1-6156eddd066d@opensynergy.com>
Date: Thu, 18 May 2023 08:29:30 +0200
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Alexandre Courbot <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe
 <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>,
 =?UTF-8?Q?Matti_M=c3=b6ll?= <Matti.Moell@opensynergy.com>,
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
 <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
 <CAPBb6MXGk-j9_hdU0DCSWoo=cUOFSxRjmLyoXObC8u2BmKeRdg@mail.gmail.com>
 <7c44f2e4-1138-ff69-7cff-11edaec2ecbb@opensynergy.com>
 <87y1lmx6qa.fsf@redhat.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <87y1lmx6qa.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::7) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR0P281MB2383:EE_
X-MS-Office365-Filtering-Correlation-Id: db8c9c0a-008c-4618-56c2-08db57693f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VxS/54EUzCCz1AOHE9+841JmpwE7UF4Qoirezntg8m3AkpYMCweOcDY2YbM34bYKOiDyPfhzqbWawyaGJfNSceyIBKSFAB2iHdxNDYx8KJmhu8gGPGpcCHz/DIv4JGejJ6qP1+7FNz/kfFcFuhOe11INewvy57iHZtpRaYh+cPqa6I79fI330tHFLJPHt8chxidzQ+hxBslz2oEbPaMfKcF17vjmS5tUAmkQtuZW/JcTBt/X9igkYekV6MkqMIkODHvIIP0MYKveJvo3n48erIoRWzNZVdgfxxAUyoCJeCbR34XaZ6UgbL5stguqpfQmRQvZNzSqlw7Zzmwi7o9XzpS3ov658Q4PrjjUtPWggZ7NQf15UHU4o1RbFuyAgm7E77GQUWc8Su2fjf9CQvxQQrc0FjaEMG9iodHsD/4elN8+DNXnn381pbibwUSe8N277hCRuuPvKgp8XFlcvDrfX5dyyoHJpJzvrXj5odOJA46MA8zFHZ5dKS86+M0ulwSZdgzSZu5cVIMk5m+0xqhRlF6/aqgPW2vBG9sucw5X7/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39840400004)(366004)(136003)(451199021)(26005)(53546011)(36756003)(83380400001)(66574015)(2616005)(38100700002)(31696002)(86362001)(15974865002)(186003)(31686004)(2906002)(8936002)(8676002)(42186006)(54906003)(110136005)(316002)(478600001)(5660300002)(66946007)(66556008)(66476007)(4326008)(41300700001)(44832011)(7416002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmZTUnJzSFhXbUNnS2hMZStWNkFZMDFsL0hpVk5rTGZHWVlSRm9Vd2ZYNkdl?=
 =?utf-8?B?UWJLbnZ2YTJLRUR0d2ZZSTMydXFKdjFwaE5FTDlQazFmOU80M1JzaVMxcTJa?=
 =?utf-8?B?U0lmT1JUNUlKOFlTUFdjMmlFbjJZM0xBL2puZzdXYm54eXRHdlliSGZ4QkNF?=
 =?utf-8?B?NFgreVZNUW0renhzS0pObFcrTm9DbjhzS0UvWVZjcklFTGpyTmlJK2o1TnZI?=
 =?utf-8?B?Sng4OEZjWlBjMHNxYjdGN3dLVG5HWTEzSXhUTkNPZjlrNUlEd3JPY2RDSHhJ?=
 =?utf-8?B?dWcyc0RGMGViejY5U1U0Ni9iWFVQc256UnI4OVFQalRuYkYvaE5YdUFUQ1cv?=
 =?utf-8?B?SFhtSFFjYUVxeGk2RUY0K1A3YnQ0SEgxZGpINk5RZmtTYldUMnFnb2ZlNnVX?=
 =?utf-8?B?UllLdThxdnkzb0xmbnFzNzBCUXVVbmprRnF2R2hpRDdiU294a0llV3owWkFH?=
 =?utf-8?B?VDUvZk5EOU9uWVBYUFhNc0VZSTFpeW5CZUZDS0RwajdZaTJCSXJVMGhWNUl6?=
 =?utf-8?B?b0Zvcjh4d0lhZUtvM1kwTHpzTjczV3d5RGEzWXZpMHhtRjJ1TG9aSUxuYjJk?=
 =?utf-8?B?S1VXNHdDT2N5N1FhOXc3Wmg4MlJrdzhBWDdYbWRsVHg1U3FUbmhxU1VPelBX?=
 =?utf-8?B?L2tDUWphU2lvb1BES21mekhiWVp1YzdCZzJKdjN4Q3RnUHd4MTFXU2ljUFJr?=
 =?utf-8?B?d0Rsb2o1SmhoVUVIZ3I3aitjeDNEbXZ0THd1MFZ1SDZsU0IvVUZONE5PWGM3?=
 =?utf-8?B?MVdlckYyaFMrV2RHNG4yaEZkQjdCU3V1TUdZNnV3dkJRcXFZYkdnSStyQ0h3?=
 =?utf-8?B?a3I1NVRWSXlLUTVQb1pLSEJJbjRwZG1CT25tczdKSUJyZVYrUW5hdlBYMzNz?=
 =?utf-8?B?UVlKcGhOR1B3SGpqMDlWb0VGdXQ3akRjYnppajRxQlRxMVFRaEw1bndHTjN2?=
 =?utf-8?B?RWI2SDFIaytBNUhWdVpQS3dqOFpIbitRR0cwak5KaWphUlZSZnlxK2gvSS9s?=
 =?utf-8?B?eWRCYlcxYUg1WGlPTHlEeUJsMzgrTHQ0ZXB5aFVaWnh0TTVDYXp3ZlRxd1VP?=
 =?utf-8?B?ZE5admlSazN4eTRoQWQvMjNnUVhPSGxiZ2pnVFBXaC9qYW1aRFhNeXlyczg2?=
 =?utf-8?B?aUJzSWFzREpOOThYU293RVQ1bnRFNDJpcWhBTU82UnFIZGNnQ1hsOGZYSlFG?=
 =?utf-8?B?Y25aRkxTOWlRNU9Icy9XYUM3UTVQRi80M014M1ZvWE80aWt1U3YwVThqWkp4?=
 =?utf-8?B?YkZXRmJEQXFNcFV4cUhFNW1PMkdoRFF1UEhvNnRuN3M5bmRveVUyQURVNzF1?=
 =?utf-8?B?K1A5alIxTGM2Y1lMWHpTb09NRUhVRWFJejJzYXREc1lmVmtFMDgxZXJidGhK?=
 =?utf-8?B?NlNNbmNXYWk3SmRTZWlrNUM5VVBuaWZKTXFWQ2tySHFJS3FLT0MxcnRqU3o2?=
 =?utf-8?B?amRINWtNaEx4eXN1OUZLekxYanBHQk9NTW5lempkMnNNK3NKWkVrSzMxczlw?=
 =?utf-8?B?T0dORnRKY0U4bTEwelRlZmkrbUU5azNtL01zNG1FTURERUZPcW8wVTd6U0VT?=
 =?utf-8?B?Rk8zWUQ4NEU0TUZjRzFic2xkMmZJNlBQWlA5Q1l1bmx1RmdpUFRUdlRGZmdR?=
 =?utf-8?B?bHlYbTBVUjhoTzNUeGVVbzFTQmNHOGJPRStsR2dyVXVMZ0F2cjNncndKYjlY?=
 =?utf-8?B?czg2Mm9iN1ZZakNyZVc0cGtZbnZBWE1HK0RKa1ZwRFFiQ3Vyc3ljNHBMd0Vr?=
 =?utf-8?B?cXcvY2NuVUd6V0JkMEtScXkxci83VmRPVlJRT1JwS0ZJM2ttUndMckd2Ukxm?=
 =?utf-8?B?ek04NEJkRHptRFVieGhGNy9zK291aUJkaHJwaitVNlRjODJ6eUlvWW55VkFJ?=
 =?utf-8?B?RGhjbnRDOC9xUUtQbGVCbm4vL04wOUtDOTZZTm9vQkJ1NHlGM1RETzFrZEpP?=
 =?utf-8?B?eVdsRW5Ec2pldUZ5dnpRd3h5d0lHY1EydzBkNnd1NHNOcHNsbWdKZXNucG80?=
 =?utf-8?B?UzdiSXJjVW1CbDh6SVZzSmxUTTlFQ0ZXeUw4UnRGbWY2N2FWUVRnRDQ3eEI0?=
 =?utf-8?B?RTJGaWVTODN4NEpIaHhmbElFUmJVYTA4RFBCMnhySWV3R3FreUEydWZydnVz?=
 =?utf-8?Q?hEUCirUx/8Wi4oDnY55IwqAaK?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8c9c0a-008c-4618-56c2-08db57693f0a
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 06:29:34.5388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQN2Di2gB/I50nH5mTWqetSdqs3fXw+/7zWXVUUGxlayV1z+EHHVp8XY4RmGFNkS6DUME2sVzcRxKyn1hG5tHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2383
X-TM-AS-ERS: 104.47.7.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27632.005
X-TMASE-Result: 10--16.485100-4.000000
X-TMASE-MatchedRID: oCj5caaCQyn/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYNiR
	006jRumK4PkIhwvBc3rNOZfEC7ZiBI0jESARlygX36lQXQeyPFE2LwvzxRX0gAziLcNJx/Sxc/j
	VpEUI2jbH6JknDAyS/MDY/raHbbeC7Ef9eUvyqg7GsO9QyW2iBJLfJ0UQgY1OHOUhijZNQhtjGq
	ZxQuvF5lRTylB9sc8Q4wqaicnh8rONQ8VRQhwTJw55FEYgJX09NYERielKfYXRnp8Qx+pp69Tru
	3GzAxaSCasoDxbsm1P9k/FBDAgpqHb7237U7CUnkiSxx29igC2wFIDW25lVJnd17Y6gGqDC/4jj
	lDwf4f5ywTNGM08Ik69JzlzkzdVL4wvfCbTuk+Fuq3SU2oCL/gZyESFXAljfrQYkvYRXmky7FY/
	sCUPw0zParA7MCidrQNubmoHTt3axHYN2JUURy7084HjrfFAS3b6LzJtd3JVrBXz6g6OAdaUoji
	kn4b0/98IAqY3n+VBVMwGFAYAh/rOP7d70FcL9rYqNes8tT2HgebEKIeRRZmBxKEIAUT+likyrg
	GzY/ECPBBqsttKK1NCAc7MI41jMTBj1nd2x734oz3wQy8LZbjEDdblTPSP4s5ZVnw3FCatqhv+N
	/pNSfegc6mX1lwNHX7bicKxRIU23sNbcHjySQQD6RpjqQGaF+gtHj7OwNO31Kzk40dEY9SBrUE4
	f4dh7pl1M9hiSrQM3mkI6Y5kwiFyVreR9Lmzs
X-TMASE-XGENCLOUD: 923a9444-ee42-4e7b-9c51-79437579cc60-0-0-200-0
X-TM-Deliver-Signature: 95A651F262521CC72EE49F36D6FF948F
X-TM-Addin-Auth: iKqRc6JfKa8l1Bb8rRVAAq1nWP4msc2Y6sq5BqJnsCx13QY3Y4js72O2nwp
	qOK4ZILKcIlyX/WMTXeLZcvDAeULLaETpWV2vr9Cm55BomgpphlzqrbdBcPrB4ptzVpGYjyCX7+
	ffgSAoRmCkS8sb9J128uHX3MLiFbl4l/A0MZbelaWKcUN6OuTa8LuTnPxawLtDi4djCUhNVdauy
	kBOn+Y22NzAAJ9S0pXeWJ/Yn81po5l8R/RFUEqxSgkvx9BjvDxSvKWclCUGaq/CUfT+xmPIefaz
	65tTf+GT35xXoY0=.ftJ5m+fTPmp6CGmyAOPe6rSgIjVtKAgtbqksMTW0meUXkgTAQbUrxUih1z
	/hZunveDJG5yNzu4Ee7aaXF39vnqdr5+SYFGHtzYjP2w7fxs5y+hgQcXHmBRntH6UR04uRIkFN5
	gy8g/anQkt6pSI1WfsGfueExS8f8UWpR4GcX+TrxGEU+8J7DhbmXYjCMcDAOK0Nr9fgnKEHmMjy
	TDwqCZrSWH5C9/bRMtZntW7pw7mDodsiCzN55aBo9+S0geU03iV/ikQcph86s+sMBLvS8vTgrIK
	arEl6PE8ooeHNGpfeA1+cOau9qlKGTSsSg0GhpASkDJvZiXwPmI5du5tzkw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 17.05.23 18:28, Cornelia Huck wrote:
>>>> I also hope to be able to update virtio-video at a faster pace. Please
>>>> let me try.
>>>
>>> Please hold on a bit - there are two things here.
>>>
>>> 1) I'd like to settle the virtio-v4l2/virtio-video argument first to
>>> make sure we don't get two things clashing head-on. As far as codecs
>>> are concerned we certainly don't need both. Cornelia, I think we'll
>>> need you to make a call on this, or at least tell us what you need to
>>> make the call. If it helps I can send a draft of what the virtio-v4l2
>>> spec would look like, it should be relatively short.
>>>
>>> 2) I (and other ChromeOS contributors) have been driving this spec so
>>> far and while I think virtio-v4l2 is a better solution, I have not
>>> said I would give up on virtio-video if virtio-v4l2 was not adopted
>>> and will keep iterating on it in that case.
>>
>> It actually very much looks like you gave up. I mean, you developed it
>> for years, and now you'd like to throw it away. Well, I meant something
>> like "please have some faith in my ability to update virtio-video at a
>> faster pace". I think I already have the permission to continue the
>> development. You know, OpenSynergy also spent some time on the
>> virtio-video. This includes the draft v1 version and the V4L2 driver. I
>> think this was kind of an informal agreement between us, that you do the
>> spec and we do the driver. It didn't work well enough since draft v4, I
>> think. Now as our interests are not aligned anymore, it is fine to
>> continue separately. I'm not going to wait until you change your mind on
>> virtio-v4l2. Obviously you're very busy with it right now. If I stop and
>> wait now, we won't have the video device in the 1.3 release for sure. I
>> think when we are ready to develop virtio-video together again, we'll
>> need a better agreement.
>
> Please, can we just calm down here? This thread is painful to read
> already, and pointing at each other is not going to help us to come up
> with something that is generally agreeable. In the end, I want _a_ spec,
> and I don't really have a horse in V4L2 vs. video race, but having to
> dig through all of this in the hope of moderating things is just
> impossible if you're arguing in circles, and much of it seemingly being
> a rehashing about who said/did something or not.

I'm very sorry for all the noise. I think it is fine to reiterate the
arguments a couple times to make them more digestible. But then it is
sometimes hard to stop. Sorry for that.

Also I didn't want to show any disrespect to Alexandre and Keiichi. In
fact I have deep respect for what they have achieved: going from v1 with
lots of TBD placeholders to fairly complete v3 and then trying to
simplify things further. It just seems to me that few final steps are
missing. Also I very much like the idea of having a repository with all
the intermediate changes. This already helps increase transparency of
the spec development. I'd like to sort out licensing questions first and
then continue with the same thing. In the end it might be not relevant
anymore who exactly sends the patch to the mailing list.

I'd like to focus on the draft v7 and I'm also going to send it to this
mailing list (or to virtio-comments first) even though I totally
understand, that the decision is not made yet and that we may end up
throwing it all away. If the decision is made on June 30, it would be
better for everyone to have a spec, that is ready to be merged.

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

