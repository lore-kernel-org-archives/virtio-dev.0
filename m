Return-Path: <virtio-dev-return-12493-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859DFC77B73
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:13:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B406942563
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:13:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A613A986491
	for <virtio-dev@archiver.kernel.org>; Tue,  2 May 2023 11:13:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 90633986479; Tue,  2 May 2023 11:13:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 799BC986485
	for <virtio-dev@lists.oasis-open.org>; Tue,  2 May 2023 11:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1683025980.536000
X-TM-MAIL-UUID: ee24246f-0601-4eaa-9f39-38bdd8c5511d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh/Ko69oSPz/sN0WBkkBMQZicF7wGiUlla/J7Z5jEy1YLkrz+EUq7kHDh9HYRGhA08ke5PRCbE53ol4egPPPIj3oKnSE8ar7pQ2J1KDdkzTyVGuyqrNIa4KXlnKLpYepAgfzW6eIsaa9pKMbtLDzb2mBujOybiD/w7Alman0X7SjMXMak3ZP0RS55khYKDGJrQdjYnUYs8RZK3lLDWVl9X4IzAsd0Se7y8K1lE3KFm5OAD68BEM3JEveLAl3JUCtU3i/CHaoZo7ZQhAPWVgfPzIW0zpffESc/o5sUks0Kv7szCsmzWtJpDyvvE2b8sDKzy8UGnttnbHhca7ZVzyvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJxVOvg/vsjr01im6I353K+C5oR1YVHqLzpe0dKCe9s=;
 b=UJZEYjQvgPZf/0p5fQmaSv9YKT5TDouxsvt9imLG9HXeu0T0JpWfeBCx6m6F5AWxBhGk/MLmJ4coql8VK93cOBumSWX96RIYhgLLQqvq0svJ7xZFmc9AER8gHfCNT15eyMKhudKsDJPZ/yxhI2GWpBnofqHlifWBkuyNIRNFkhYLHC9czZReHpCzlB8z0G67665rasKMRvtOwt1ycxYEtblhjIqnyRCZNI53RdAOoF2R9J9oVVOZbNcwlOFS9T84SxGesmOo+I4K8WBP0ji7ITOkHQRQyFKkCNhffg/ls1tuHcR4kopg29wBwMZIaZCdkAJ98BmUxbJNDfUalUZqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <78997945-f7fe-56cd-b8d8-a2b429ac4a07@opensynergy.com>
Date: Tue, 2 May 2023 13:12:57 +0200
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
 <87a60kg9rh.fsf@redhat.com>
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
 <87354okkx5.fsf@redhat.com>
 <c1658889-0a90-5681-6afb-7160cdf1bf77@opensynergy.com>
 <CAPBb6MXNUHJuq40-RQO-0aa6UU0R_ZOHvB48B_t_knpK4Uw0eQ@mail.gmail.com>
 <0f67a3ac-4995-154f-142f-d49d1684aa3c@opensynergy.com>
 <CAPBb6MUEtC1oyEVq4iwdBG0vMj3FwJ2+Xr+-d99ygCZjp6f39g@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MUEtC1oyEVq4iwdBG0vMj3FwJ2+Xr+-d99ygCZjp6f39g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::9) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|BE1P281MB1716:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e3d5e2-564e-4493-5ada-08db4afe2fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qv0uiWBgcsxBh8kQmqYjN5tFwLK6cHuKgVgJnouNTeaoWug4mhu6xzaLLLOn2MjWExARQqtVvoSWnPPkc+7EWLwvucR/W1OpPcXNlyKKB6cpdEFCrPZOk+pcg6Q+HUlDN1zISLvSnu64nTD6tEWeTI92h9AUbMR9bzYDX15siV/rBu5vAUu3cGF2zdbhgKb0CyNm1FPcMKSBH0r0QD9lWeQN8gOFomc1nX/p0K7E3KBPNvqJ1ETErEvEiM4bazuCCtnI9xDWlEZNhxWZ4oaDhO1D1UyQDPVRw/v6sCEbCRiYVuvYdEnHxChEZz6PX7pjPxhFQiEwboHALl7hbDzcAzquUaqKGwqPj8cbYXQynlZxmN8A62KhMdzStt9gq7yd/ngiGDCcYoQCATblPmdg8Xh9WdaDkkk9d1FstW9pHGYb/62lHBggk98Lb8icc56APAjIw6tGUfcYqbtvvaMcrHGubVeTOyd9/vbN8EzZj2o75O4hSY/bJxe6dB9Kj5JfwbtKNdGWC6LaVlYJ5DQkP8sX9WxNJaEp/NU18Wezr7esGYF8X4tnyYM4wEbBvfTTVrqYIMjwLM6aWUI9OsRR6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39840400004)(451199021)(42186006)(2906002)(38100700002)(66899021)(8676002)(7416002)(44832011)(41300700001)(8936002)(5660300002)(15974865002)(36756003)(86362001)(31696002)(26005)(966005)(54906003)(478600001)(53546011)(2616005)(66574015)(83380400001)(186003)(31686004)(316002)(66476007)(4326008)(66556008)(6916009)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2M4Y0JMRjE5bjROcFhtaWlybXNUdmlsWmMwa3hORlZGRTh5ODQ5T3RKcHhD?=
 =?utf-8?B?T0lyc2hOOFJsYUtzYjlwaG9wbnpnSWp4dExwS2tsSDYzdDdDQmVPdGFseW1O?=
 =?utf-8?B?dFFRNUZPZHNvc2ZSbjRMYlQ5aHFlVnd1djJNNWJuWk5ja2Y1bnRCeExXbm9p?=
 =?utf-8?B?UEV2eTdkandJbDBTcGxSQWRMZHNOUDVaclRRZXFZU05WejljZHMyUHAxMVMx?=
 =?utf-8?B?RkNUQXBLb1V0VVFJQy9wNjJhaHUwUk9Wam9ZWFdYUDFlc3dyeGZLeXUzNnJK?=
 =?utf-8?B?V1QrZGFHbTA1R0tvMndxRE44VEJUUGhlcUllUzNnNG1PbWhmZVMrMmREL2Zp?=
 =?utf-8?B?VGdleUNSc3V6N1VnRmtRUGdVL0pHaDFkMGhqR09XVWFLeWM4cFRhc2FDK2c3?=
 =?utf-8?B?dDFjbDh3WGVPbFhYaS85TWsySm9Cc3piK3BJVlpTRzFYWEIxc2FqRUVEbDdk?=
 =?utf-8?B?cUpwTUdnSnVhM0phOCtjTFFEQkx5V3VHN205RnVJdnQwdmkzdFgxR2o5ckl4?=
 =?utf-8?B?VjdCeWlZTERHQlp4MHg5clVBNmZQTlBEdTFGaFZXaXZ2RmdPTnR0cnRZTVRB?=
 =?utf-8?B?QU4waUNpRnBWb0NKa0l0UDV4eHlzNndRZVh5em42cnY2TFQrdFdXcDdiZlJw?=
 =?utf-8?B?aGFhcjNOSk1nWk1QSGpSQVcwUG9vM3FIalNHVG16S0c0MVhaSXZsUkQ2dmF0?=
 =?utf-8?B?OC9obHVGQmNMUjVPcFZuSFBtVkk4c2U4d3U5OTdTbmNkZEVsc1RRbDVjbnd0?=
 =?utf-8?B?SDNSeTl4ZVB3N0lMakkyNUgzNVlzZ055MFdSVm1QK1NKWTZSOFdiTVlLNWV5?=
 =?utf-8?B?QitXcXNzeXB3LzM1eDg0RmNEd1hPZmFVeDNQelF6T1p2WDF1aC9tUVM5cDZU?=
 =?utf-8?B?NG9jQlBsNEd3R1p3emhWMzZnTXBQTzk2RGx3eVFEdGpmc2pjOWNDaGdVcXV1?=
 =?utf-8?B?Y2ZTTzQ5elNnUHRpenYwOVNvZitiR2ZFRFNzY3VmTFNSam5XRzQvMG1GYk9j?=
 =?utf-8?B?MGY2MFR4ZFpBY2dzb1NMelpnZ2VZTnlXWENLYjFEQTdmMVFleldJcmlRNTl3?=
 =?utf-8?B?amtmT2E1bmNUZWpveklTUkhXOXY3NW5FSmlyTWxtSVhGSVl6NDdLQVZUUGlN?=
 =?utf-8?B?VE56ZVgyZmFYYitGMEJMT0dZV1VzK0k0a3poVU84ZmxremdtUWdIdWRsRG1z?=
 =?utf-8?B?UkhwWVBVQnVpRXN4ek9DRlZNZDdGQU5hRVpneWpkTjEzVVJmWHJwKzlLbSsr?=
 =?utf-8?B?MUM4eElPWC8vaUVzMXpRWW9sUnNsUGt6VTdnb3Y3NGhYWng2dC82WEV2eStr?=
 =?utf-8?B?Z05haVEvWGs0SnhqMnZmQTFkSldtUVp4d2pxOTdEQ0tOeWFLdFlkZTlmMGla?=
 =?utf-8?B?NzAxZE03WjZBY05vZFlTYTA2UEdLbXNyMVJsRFIvQUdkRGlIcjRHd0pMT291?=
 =?utf-8?B?bmpmSlFvY0cwcnlEUGp1V3NYOFNtbHNNU3owaDJQTGxZZG02OVhyUDI5cVNL?=
 =?utf-8?B?Z0pDNElFdGs2eEhNNHRIbkdORDJlODBRakt6Nm9Qd0F0UE4xNVd1MWo1M0kx?=
 =?utf-8?B?aWZmZUJDUXBaeURYeS9BV0h3eUxKdXJYSUJWaUd0QXhTRytVOG4zTTM4MFB6?=
 =?utf-8?B?cnJBNFUwSXJlRzl4emNHMktPRnhLN2oyQjhhZWZrcDNDQmJoOXh4bHpMT2dS?=
 =?utf-8?B?VEZSTVZycUtnTGI3d2tSdERiblJCTFB3SEtuS3c1ekFNTU4rWHBDekM0QU9m?=
 =?utf-8?B?cnZUUll0UWJHY1lac0Z3Nm8xUWptWE1GbXcxcnVsSVcyUXRScXlOWFM2b0hQ?=
 =?utf-8?B?RExLeGhoMVFkSVhwVCsvdjQ2QkVHbS83NTl3ZE80cmo3MmpySlhQblhQamx3?=
 =?utf-8?B?RCt5ZElZeVNPbVBDQzd2V2phcU8vV3pUbVVWbHBvR0pVUm96cUVjWU1hWloy?=
 =?utf-8?B?cVlucDMvVHAxVGJDeUJaQzBheUt5ancxd3dTdzVvZi9xWnF5OFZQWi9xWGZr?=
 =?utf-8?B?TEhweDJuTFh6Z0NJbCtWdDFHeWgwelhZdVpvYVBHazlLZFFlNFJaZEFJck9I?=
 =?utf-8?B?V0YyRWI5MDMxZ3pQVU14MXZ0WUtoTERMTUx3bXRRVmJjVi96cjI4ekxNSGRa?=
 =?utf-8?Q?6LJFSlj6httVUMv1p6HBdqvS5?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e3d5e2-564e-4493-5ada-08db4afe2fe8
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:12:59.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OGolEhmJPeBEGFblMWS+4k1bd+LtwpQSr+VLRfu6LiiIOSXn3q2YWGTSTEO2z5jUO+JnBwsPuJcHCY9USQDZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1716
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27600.005
X-TMASE-Result: 10--22.804700-4.000000
X-TMASE-MatchedRID: u6ojmU07PKz/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYG1A
	+PyfVi9VXnkEfGIdlzfErKZVJCtGzsEElERnDJHCshZoVNAELFPkzWxwXGSAYT+B/tp8itBTwmq
	SW0kcMLatVnlxd5OEdNwoJ74c3x8zKyefC7mVhWGIf3m0sUfx5za9tZoo+dDb9mqZiOfja89yAu
	/UL6iDH2gZMh5YZNgQPXzXTYVZQI0v9901qElB+t5x7RpGJf1alKvhkP88iXSwuKAMD8Wm9VDOm
	RheGpIyh0hur+k9vDOpaNKvECOILA3NgVL679KbmIe0I1iNyQwuH+p7/wumBtP7VmP7Drr6Ck/v
	hGfHFeSFW+x5HzbUdquxWtAe4PJpOrPgsAyL7VGW7zl29p1xdcMFDjMfv7kD8f3rOEwXzqcrqUy
	AbIF+KapudRsisNuFijy4xFF9LdTjFqkZIdiuS/QAclqqmRB80w14HFJQjaP8/1ypXUBGlc65Qe
	rn2w9CywMD+nV5RTgOpmVTrU4wTF8+dSqKgz8/dhkilCSjv7UNW4va9iqt3pC/BCs92qoiINgIp
	AA8LuOKXPHHXDmlw+I/i7CQzrdqqJIiwhbq5S9M0MpnLn+G9C62GA8VkuOa/e5hRw9VtK5S3eAH
	zSfkkLs8IMNI7NJ6uXFEQJaCEz6/WXZS/HqJ2sC4UUZr4lSF3Mh122xXdCt4N1jhRVQFLbxAi7j
	PoeEQftwZ3X11IV0=
X-TMASE-XGENCLOUD: 61b002bf-b4e8-45c0-9672-04d4de2a91b7-0-0-200-0
X-TM-Deliver-Signature: 9ACF573D0F1632022A38FE34A30B13A2
X-TM-Addin-Auth: 9aWZ5bwbMy4s8ak0lTHEYKrF/yLvC8Yl6bSjkUWYGxCK0xk7v5F2dzWW7vC
	gcEE5ucwmIjJydktg5pjETbkzCHwsznZXR0VmMhF9rsBfsOw0TceDfMloFZ4KXFzBrRmhCEzvR6
	1kWAmK0scFRqStBC9rthL5a3Kqr+7m6HKxYLo/1Lqt0UUhBTO1NLQetHp8HpwoZh3SnHrXzUqRA
	3BltKuwEE3KYeQjaW/oIKS4a7RDyKZzlMCt5GdHiqHPoOH6VPx/ZLh4WaLfQB3SQnfzAAu4QmGu
	/Erzg5ewyJoRd2E=.LQRjYR74T0loo1Qe9YeAyxWXTVVchZyYqfYCBIXzAxII4paw142jHbrjhN
	eBNKSJNWB9CqdIQkpK90Qi7vrBaDX7eLWbJNo0VFP59JIXbi9zYyg7bnOPelFRTNN1IjGZ3SksQ
	KHt4Fb1E8Vq8P19yv+OhYuuyMkTfWy5TMorCkAbg27tkoMolRh5zlcMOtHLbgHFXJLHxzv+ERoa
	iO6AmesOZaeoJaUE217hiP8Fx2XtIrFI4Ant5vOgl/bGMQ26+29dU1OqWJWS9RWiTi+OHNeCKEr
	VzwnMOIdKJBNbd0kcDiMh5DR2CNwnviHCB6q60j3LbQ9p38r+DsNnvoOcdQ==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 02.05.23 03:07, Alexandre Courbot wrote:
> On Fri, Apr 28, 2023 at 5:55=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 28.04.23 06:02, Alexandre Courbot wrote:
>>> This is going to be my last answer to this thread ; I don't think I
>>> have more technical arguments to give than I already have and the
>>> discussion is drifting into territory I am not interested in engaging.
>>> At the end of the day it's up to the virtio folks to make a decision
>>> about what the best course of action is. If we end up with
>>> fragmentation, so be it, it will still be better than the current
>>> situation anyway.
>>
>> I agree with the summary. I think we have discussed all the things in
>> depth and even reached some understanding.
>> Could you please at least share your feedback on my proposal for the
>> QUEUE/DRAIN completion handling?
>
> Well I've re-read your email once more and again I confirm, this is
> exactly what virtio-v4l2 does. Here is the code that sends the dequeue
> buffer event on the event queue after a buffer is dequeued on the
> host: https://github.com/Gnurou/crosvm/blob/virtio-v4l2/devices/src/virti=
o/v4l2/worker.rs#L1114.
>
> IOW, there are no VIDIOC_DQBUF or VIDIOC_DQEVENT (or any command that
> can block) taking place between the guest and host, these are sent to
> the guest as events.
>
> And yes, this design simplifies things quite a bit vs. retaining
> command descriptors until some operation completes. Beyond the
> increased potential for deadlock, there is also added complexity as
> the descriptors must eventually be returned to the guest, even if the
> requested operation is interrupted. This increases the amount of state
> on the host which must keep track of pending operations and cancel
> some on occasion (which is pretty error-prone), whereas having all
> commands complete without delay could theoretically let us function
> even with a single command descriptor. Retaining the descriptors was
> supposed to reduce host/guest traffic a bit, but at that level of
> interaction (60 ops/second for a high framerate video) I don't think
> it's worth the cost.

Thanks for the clarification! So this was a misunderstanding on my side.
Indeed I'm still thinking of virtio-v4l2 as a V4L2 UAPI pass through. So
of course I thought you have VIDIOC_DQBUF and VIDIOC_DQEVENT. The
design, that you have in fact, indeed looks better to me compared to
having these ioctls passed through on the commandq. So doing the same
thing in virtio-video shouldn't break anything. I'm happy we agree on
that. I totally agree with you arguments in favor of the events.
So virtio-v4l2 is going to have quite a few patches on top of the V4L2
UAPI: the memory types, the way events are passed, maybe also more
restrictions on the data types (this can be upstreamed hopefully). Did I
miss something else? So probably it is better to present and think of
virtio-v4l2 as something like "patched V4L2 UAPI" to avoid confusion.
Now I'm really curious what the virtio-v4l2 spec would look like. I
don't say, that I'd like to give up on virtio-video. Please don't get me
wrong. I still think it is much better to have a readable clean spec and
to avoid all the patches, because they will certainly cause a lot of
confusion (like what we can see right now). I'm just glad, that we're
going in the same direction from different starting points. This
probably means, that we both do the right thing. Good!

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

