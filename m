Return-Path: <virtio-dev-return-12478-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C103EC77B60
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 08:22:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CCFFE3E316
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 08:22:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DFBC986699
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 08:22:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7FDB5986681; Fri, 28 Apr 2023 08:22:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D9AB986682
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 08:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682670133.116000
X-TM-MAIL-UUID: d06a369b-f553-4179-9244-c9c4ea5a75de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC7ZDNn/xAb6N+Rg+TJNUiaXBrnE1JX/g9i2Lz2d02XErRRQkq0gg6KHMwpcFhXYbe0x08r23OoK1m0aozipeerrteVpVOApS/H33UJT/Hwlc8+pS2nGt96WtGs2Q2HpWqQXyC6zTyYNg4KmSYFOl0LdjK2Klpekhis0yal44OAd1jGEcEhY2PDnSj3BcF2/xnV8U/2vQJpeCbO+bEW9iFRkBQ3i6AzpcdxCmd6T+0veCYWACJ7eM+juoXbdH4jLsQJFYv3VwsFrAh6BW449jifH7NZHZfmNzgKJqN3OLoQT45okGgSI5OXMb6ED22hq90J0HVpxOmYLzCVyd1cUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yHQs34pX2oQG9S5MeixkgsVvXMGACLVw+5z0bcTfZA=;
 b=FvY4Tyj82p4aoEXG44KYT9rmacPIMoZmoAXqU9IV+ScjMCA9vmnzqT44LhM61Pm/FKfjQT60CXXDbg8gff7bnofsmdILc6lLDsqL9GT7kAawY0ZroreMAzEPTn7DoTaEbzI69VAo8BTg0dEyxR+/W5GAJlfdQgxQUJAw+X3pxeywQBZyigMxk/EeppKv15w/Oqw8WPejegaM1j8/7GmbCE9ItEuviqpPrKaIjBNL3rWSFDAHcXQh9lDO3IfL3MyMbhhEF0nWNmanF4jJfe8/hy5TTeCIGnCnA81iOO9UQDYosH7sDLdr28o12cBhAmLZljjeXUwREAQTfX73EK4OJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <2ce708c1-574f-6021-4f94-eaf88be3161c@opensynergy.com>
Date: Fri, 28 Apr 2023 10:22:08 +0200
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
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com>
 <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
 <CAPBb6MWMjvTiAdCwfUH62EpqYLHotFoDg7hAfqY2oLkpmYM_HQ@mail.gmail.com>
 <b2d78c20-8476-ccda-42ca-6863f44b06ed@opensynergy.com>
 <CAPBb6MVg3rcWK2XVXEPAijD7ETPDqDnx=LiKrK6aRq0x5bYVTQ@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MVg3rcWK2XVXEPAijD7ETPDqDnx=LiKrK6aRq0x5bYVTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::8) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR3P281MB3039:EE_
X-MS-Office365-Filtering-Correlation-Id: 9706b67f-e560-459d-93c3-08db47c1aa81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Ip5cy60hRP9MXjOPlUqTV5wLB8W696RMTwdebp2CC2OTjWS3F73l3WOW9QagFXL0ZfAA9Ubmlxx/p70+4S8qnXk+mTapN5SMgWgiaWDvs49xiO31zkaiI6F05HxVnh6Xfe+wLpzNEeCTEsnrrTdBXqqXSW9ilbSYR84BISVGHJ1czDFTQLTGIsjmtTtSpQqTcvqLZvFrO2SwzG3KBXoz5M8/UispqSKjQX1CV8MnBJECta3fA1IoBLbNsQzImO1KBOCHmV56klZTM/MgtnWVueYnL2CYqym/WNOFu/KzYPdR5rajLN2/4zpGz8KbnZpcGCziPybeo3XC70a2fUQn79lbIQ+JxP/j8NAg7o3hXvFq+Jx6J69xDvqwYcPjq/uhL7hy1b0A1sQraP7kzL30Oe9qHoGu2HOppGUjvnUENNS8yDiGExMXiQ/g8pzXdZqKg9BAoO6nut/XHs57Va+Ku2joeS7IZJE5BzY2vuaFPd7UEd5GL2LbJ36RHkXICi80A864IQi9/IoQetv3OKWSq+cbtIjdh0g3yQ1prMUXFLwlQNbSGBrZyUvqPuoBq9yNbwGzk74uqIds/xL6qpF6EhqGDgYJIHqPk7jeAfhVBnDyEA4TGhKXkndyJMVnYub3YRFGQQiwMqjvFQjNuUECw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39840400004)(376002)(396003)(136003)(366004)(451199021)(66574015)(66899021)(42186006)(54906003)(478600001)(5660300002)(8676002)(8936002)(36756003)(2906002)(86362001)(31696002)(15974865002)(7416002)(44832011)(66476007)(66556008)(66946007)(4326008)(6916009)(316002)(38100700002)(41300700001)(26005)(53546011)(966005)(83380400001)(31686004)(2616005)(186003)(5930299015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUM5dzZ4MDdaR1A3cDQyR1FOZXFoMVlOaWNBN0lsLzNQVkVQUjdQM3FGZXhl?=
 =?utf-8?B?NE9OVHM2cXRseUkwNlFrRnJDcnpkRm05N09tQVNoR2RvVWZnVVJOZStJZGww?=
 =?utf-8?B?eEZzeXlwRTBPbCtDZmNVVTZZTkRmL3lVL0F3NVBvWFZIdkRTRDhPbW9uSk84?=
 =?utf-8?B?Y0paa0RJa04wd0RXbjJ2NmRjeU5DYjNQWnRaZ0xNWWI0STRQcWhDbFY4ZHkx?=
 =?utf-8?B?NG1mRklyVVB1eithaHJ6OExGa3EvUjlIZUh5RXd3SnJxcnVoK3RXRFVLTndu?=
 =?utf-8?B?cnhnMVhjUUh6aUJVdzVCVE51NmFCUmRRQnN4YlpUc2hHbUoza054cGxrM01X?=
 =?utf-8?B?V2pGZEVvK2dlNmFna2NzeTRUQmlwOTFNKzJaQmlkVy9yWjd0T3YxNUJLbFZo?=
 =?utf-8?B?UjRwT250QTZ2QlN0ckQ2eEVIVlJLQjZjQVNIUEJnK29UZ2Z2VWNCMDRtbnow?=
 =?utf-8?B?bzdRYzVwMmY0OTJ3ZXVHeW5TT2w0U2w0Uko5UGNwNkdHSEVEQVp1d1pXejVN?=
 =?utf-8?B?L3IzQ0NRR0Y5dlpSTGd2NnpWck9KdlRNajhNT1ExNFBGWkxYcmduWTBOWEpu?=
 =?utf-8?B?aSt0VUIwYUlnS25QaEN5VWRlbjV2Rll6aXZ4M1ozMFRaVzJYeHBlaTZweXJz?=
 =?utf-8?B?NE5malVQcEFjNFptbnZnOW5peURWUmVhNUVMV2FJTVBzT3FhbWRmMEtwb0tX?=
 =?utf-8?B?YnFBa0hkMzJuOGZEQUlKVHBseWFyZDkydlhYQ3B4cFViYUduNlJGTm0rV2pi?=
 =?utf-8?B?UytBSHpqaTdJcW9ud2Q0dmEza0tZUDhTL1RJbG4zSkp1VGI2N1JBZ1FNZU05?=
 =?utf-8?B?dEcrQXZ3MS9RajFjV3licWUzWDZxL3FIUkZPWFJkbE51ZHZxL3Z6VDhCdzc5?=
 =?utf-8?B?dVROUVM3ZHRDZlRSTGtZWmIzS3JnWlI5dTdpQ0YxbzZYNHdsZmpUeHZjbVFj?=
 =?utf-8?B?ejlNV1liZ28rMmZMdU1vTFBqQytRcTVjamZwZDVqTGhNa0RCa1RwUDZ6a0lK?=
 =?utf-8?B?c2NRb1J5RVNMYk9QeXpJdjMyb0RlbWFESjJRUDZOSzdTaktyT3puRSs0bmll?=
 =?utf-8?B?NVYxT3RVWDNRSUFtZnVMNXFvdDBHZ002a1k3YjBvSUlRTHlBMnFlTnpUMHJB?=
 =?utf-8?B?eVVNSTVqMDIvM3hnQ2ltZzlzN3F4RVFOckNLenpKRWlWRHhaOWgwWXNPTkNq?=
 =?utf-8?B?cDBKWVFTRVh6RTczMmhUMVZHcitucnd0L3k3N21hS3NIdWpqbzNVVm1VM0lx?=
 =?utf-8?B?V0M3WkdZd3FhU0xsM3lzMnlnU2ZOMUhJakpaMWswTnp3eXZSMGlxRXBEbjls?=
 =?utf-8?B?YTg0Y0hTYmoyZFd6SllCSmtTN05JWGRXRGRpTStZMzExZGV2OENoSXpWUE8v?=
 =?utf-8?B?WVdDR092ZGI1bVQ3TUpjcUUxTzJ0VHlNVENSaHJiSVNFbHVTOWdjSTZtN1U3?=
 =?utf-8?B?bDJYZ0tUaUpnWExMYllSbDlvOE8zWEliSFhxdUpHK0ptdzZKcUdtWWRxbWtn?=
 =?utf-8?B?eFVwUlBlck5saUdCV295ZjBsRkQvclZXNFdlcEFiZHpkdHVERzY4UTZZR2RM?=
 =?utf-8?B?ajgyYzcyMkxwVmxNK3FrenJIZ3dKbUphc0hMZjNPeWNKaEVIYUhSMzM0UWhX?=
 =?utf-8?B?a3NrY096VVU2OGlYNlFIUmJRSE0yUDhxM3RreWRuaWVBMHFzRUplNldHOWd5?=
 =?utf-8?B?M09FbWpENDFVdXowbVNwcjZBOFFaVGlnSU5QWDdGWVN1TjVoUW5yQ2FZek1o?=
 =?utf-8?B?YTk2bHFrY0cxczh2d2lYZkNuRW0rMmVLMU9Zb1hmTERxNFNmUHhvVkpWd1k1?=
 =?utf-8?B?WjU3TEhlanl4dG9tWnBIbmdmaFl5SS8zaE82cG5LaW1CTkU2RXRWSnVZUEor?=
 =?utf-8?B?QVc4VWJYaXErZi9Scld0ZlVjN3JlUmdTODQ3L3B1TVFtZjdFTTYwUUdDeEVR?=
 =?utf-8?B?OEpqZnRFVFpKK1pRa2U4UTYyajVHekxIMTlmc1ZwUldmc0FxeXRLYnJUNm9Z?=
 =?utf-8?B?WnlhcHd3QTVmYTVwQ2RTd3ZFanRRUWo1QkljdytLa1E4VTBIUi9nYTJaRnNY?=
 =?utf-8?B?bHV5UDJ3djJQTU9CN1h5d3dGZWMxeVRnM2ZxSWJXb3FXRW5ML1dyOFJjNzB2?=
 =?utf-8?Q?2o2c/PVhz8i/yN3GAH6UoivsR?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9706b67f-e560-459d-93c3-08db47c1aa81
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 08:22:11.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0/0tSN6d1ZRVWM9f5ReifghRC5/MPPSgLi9cbpxE1VXvFsoGNMD8W2oF3jXFiES6nPmyyAiQw/PpYCwkl9X2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3039
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27592.006
X-TMASE-Result: 10--27.405400-4.000000
X-TMASE-MatchedRID: B0+RG8xpjtT/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3Qc0C8Dp8kkTtZOu
	v4LVY2bFzkgzzcA6iXgA9kG/R4Hl8r8aW4fXpQCdM6A0eGVTtgwEa8g1x8eqF4YP07e6LWHYCMm
	WJ6tUT+drPg89NCqC9lmzi6YL/Qu2qcvngzkLMRBXIAoAy+PWmlC7s5KMBBLaUjL5+3oRqLZJTL
	fhtwUcmxfMOKV50pU+fJL38u1VtO7fytYpCSLCzjhk1eHxQ+sgI3CelQUbNBxYW2UHFy8y3/dIm
	8S+G8+gXiogWO6YsIgbK4UnVFqVx5n9tXfhqBVsxrDvUMltogSlY4F8r0vXPzxzAG47ocHfEpMY
	0o/BrKf56Gl0UBOAzlT3VFZ8BnsHoGg41PayguTece0aRiX9WsnlJe2gk8vIccFuJQKh5x7ckHV
	gh/2ICh9Zz3uugxUdcQfBx409I+gPgCQ1Nx/qoBFbgtHjUWLymLueCjm/53Tfk9mxlw4tGTEnOs
	mDq/ZzmjOhWua6FpKNfC8ruwHBWkDl6nw/R5dAKwi7MItzaY1SuvtBzlaEqJ3D/L/VDs+pTL9z8
	VngfRvTNC8gZJ/b0Ka5yX0vLefgUrwdbkFhiu6TeuX4xo2DEBxCcOlDoVfTUuEXmXnLtqKVgYtG
	n5wOd+wd2k0afAEWldfwC3vgBQZjDV//SvkH3hHJWwDGGGOsKTREEsKJaMl9ZDXSzHFFNye2Lhy
	YwFNXqnzsf80F4qWn4Y72zBxg/5lu9ppR3hvD4yNMhAgBbituUo/YRNEhmcEguqiGeZ5Jo8WMkQ
	Wv6iWhMIDkR/KfwLkblkrgCLv43QfwsVk0UbslCGssfkpInQ==
X-TMASE-XGENCLOUD: NULL-NULL-5-0-1
X-TM-Deliver-Signature: 7457FA7C883356D2E57CB7C33ED61F60
X-TM-Addin-Auth: fSeg+BufM3EraigWtpSJupytMbKmhrytnY7btOUzEgFqseHy7+FoTlCvup9
	6f1G5uaaWfDogsfDbecnl6mn/A7TrjEztxBP18WjOtclbVonNsL09asp0TtqepVdRWIlLWInVVj
	x85yiHdbOS+7CV+cksXsLPp16MZt4zY+Xvf4vyZlJUFqr17exte3efzwLzxT26dbvznjI6eeS1p
	Jhh2POurLYf4sEX9WBuiMzneLKQT2sBLtI10gmkSzQxbz7bIy2r3FDrofeVe03zut2F2qMpbLCL
	2lssr4k4taIoxy8=.xds1qprjw5ZhgSSQn8uCmp3Tz+7lAPQNgSzskkq/uMsevJbkO2UKiCznrJ
	Aa3OXBX+PoX0pC/6G+l6YQMe6K9wiYNkNTsxvWIXYUg8m2VVqSaaXzOwmS9ywk94+S2CaOx7Yb/
	qMGUy0R2InofBgXSuBRTqHXsNB0ivB/0H4H9ZCpEdndkVthgGjKt0m+YtLxOGsEHT43GD7kUGkA
	DeTTByRTIos0pY16ELG1Xpy5j1BZ4F+8evJMwn5z/bA5Zftdi5lEQBMdSG+h8IVUbkJIMMA5TlS
	T7BvTPmd4uJRixbmd//+hatcY1Cajz0wxPE34LfvoHYB2mgQn0Y+cWNhG+A==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 28.04.23 05:22, Alexandre Courbot wrote:
> On Thu, Apr 27, 2023 at 11:20=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 26.04.23 07:52, Alexandre Courbot wrote:
>>> On Mon, Apr 24, 2023 at 4:52=E2=80=AFPM Alexander Gordeev
>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>
>>>> On 21.04.23 18:01, Alexander Gordeev wrote:
>>>>
>>>>> Let's compare VIRTIO_VIDEO_CMD_RESOURCE_QUEUE with
>>>>> VIDIOC_QBUF+VIDIOC_DQBUF. Including the parameters, of course. First,
>>>>> let's compare the word count to get a very rough estimate of complexi=
ty.
>>>>> I counted 585 words for VIRTIO_VIDEO_CMD_RESOURCE_QUEUE, including th=
e
>>>>> parameters. VIDIOC_QBUF+VIDIOC_DQBUF are defined together and take 12=
06
>>>>> words, they both use struct v4l2_buffer as a parameter. The struct ta=
kes
>>>>> 2716 words to be described. So the whole thing takes 3922 words. This=
 is
>>>>> 6.7 times more, than VIRTIO_VIDEO_CMD_RESOURCE_QUEUE. If we check the
>>>>> definitions of the structs, it is also very obvious, that V4L2 UAPI i=
s
>>>>> almost like an order of magnitude more complex.
>>>>
>>>>
>>>> I think, it is best to add all the steps necessary to reproduce my cal=
culations just in case.
>>>>
>>>> VIRTIO_VIDEO_CMD_RESOURCE_QUEUE is doing essentially the same thing as=
 VIDIOC_QBUF+VIDIOC_DQBUF, so we're comparing apples to apples (if we don't=
 forget to compare their parameters too).
>>>>
>>>> To get the word count for the VIRTIO_VIDEO_CMD_RESOURCE_QUEUE I opened=
 the rendered PDF of video section only from the first email in this thread=
. Here is the link: https://drive.google.com/file/d/1Sm6LSqvKqQiwYmDE9BXZ0p=
o3XTKnKYlD/view?usp=3Dsharing . Then I scrolled to page 11 and copied every=
thing related a text file. This is around two pages in the PDF. Then I remo=
ved page numbers from the copied text and used 'wc -w' to count words.
>>>>
>>>> To get the word count for VIDIOC_QBUF+VIDIOC_DQBUF I opened this link:=
 https://docs.kernel.org/userspace-api/media/v4l/vidioc-qbuf.html . Then I =
selected all the text except table of contents and did followed the same pr=
ocedure.
>>>>
>>>> To get the word count for struct v4l2_buffer and other types, that are=
 referenced from it, I opened this link: https://docs.kernel.org/userspace-=
api/media/v4l/buffer.html#struct-v4l2-buffer . Then I selected all the text=
 except the table of contents and the text above struct v4l2_buffer definit=
ion. The rest is the same.
>>>>
>>>> Also it's quite obvious if you look at them how much bigger struct v4l=
2_buffer (including the referenced types) is compared to struct virtio_vide=
o_resource_queue.
>>>
>>> You are comparing not the complexity of the structures but the
>>> verbosity of their documentation, which are written in a different
>>> style, format, and by different people.
>>
>> I agree to some extent. At least this benchmark is simple and it
>> provokes to actually go and look at the definitions, which IMO should be
>> enough to already see the difference. What could be a better benchmark?
>> Maybe counting the number of various fields and flags and enum cases,
>> that one has to read through?
>
> I give you another point of comparison literally 5 lines down my email.
>
>>
>>> And the V4L2 page also
>>> contains the description of memory types, which is part of another
>>> section in the virtio-video spec.
>>
>> You mean only enum v4l2_memory? Or anything else too?
>>
>>> There is no way to draw a meaningful
>>> conclusion from this.
>>>
>>> If you want to compare, do it with how the structures are actually
>>> used. Here is how you would queue an input buffer with virtio-video:
>>>
>>>     struct virtio_video_resource_queue queue_buf =3D {
>>>         .cmd_type =3D VIRTIO_VIDEO_CMD_RESOURCE_QUEUE,
>>>         .stream_id =3D 42,
>>>         .queue_type =3D VIRTIO_VIDEO_QUEUE_TYPE_INPUT,
>>>         .resource_id =3D 1,
>>>         .timestamp =3D 0x10,
>>>         .data_sizes =3D {
>>>           [0] =3D 0x1000,
>>>         },
>>>     };
>>>
>>> Now the same with virtio-v4l2:
>>>
>>>     struct virtio_v4l2_queue_buf queue_buf =3D {
>>>         .cmd =3D VIRTIO_V4L2_CMD_IOCTL,
>>>         .code =3D VIDIOC_QBUF,
>>>         .session_id =3D 42,
>>>         .buffer.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>>         .buffer.index =3D 1,
>>>         .buffer.timestamp.tv_usec =3D 0x10,
>>>         .buffer.memory =3D V4L2_MEMORY_MMAP,
>>>         .planes =3D {
>>>           [0] =3D { .bytesused =3D 0x1000 },
>>>         }
>>>     };
>>>
>>> In both cases, you pass a structure with some members set, and the
>>> rest to 0. The host receives basically the same thing - it's the same
>>> data! The only difference is how it is laid out.
>>
>> How do I know this from the text? How do I verify, that this is correct?
>> Can I be sure this code is going to work or not between any device and
>> any driver?
>>
>> With virtio-video you can just go to the spec/header file, take the
>> struct definition and simply set all the fields.
>>
>> With V4L2 UAPI I don't see any other way except going through the whole
>> buffer.html file, filtering potentially irrelevant stuff, then doing
>> some trials, and maybe looking into the device or driver code. Maybe
>> also asking you for an advice?
>
> The relevant fields for each decoding operation are clearly detailed
> in https://www.kernel.org/doc/html/v5.18/userspace-api/media/v4l/dev-deco=
der.html,
> which I already linked to multiple times.

That's true for most of them. I'd prefer a single document without all
the irrelevant stuff at all. So this one is not quite readable and it
never asks to zero the not required fields. Still this is bearable.

But this is not true for struct v4l2_buffer. I couldn't find anything in
the document, that you're linking. I went there and rechecked it again,
still no. Where is it exactly?

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

