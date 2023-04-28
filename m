Return-Path: <virtio-dev-return-12479-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B449FC77B60
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 08:31:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DC29C42A6A
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 08:31:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF23F98668B
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 08:31:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A2C29986681; Fri, 28 Apr 2023 08:31:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90C00986682
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 08:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682670671.080000
X-TM-MAIL-UUID: b60686b0-2699-4847-9e53-8361c69e5b52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4fhy4SXV5Fmxdf2ZkOGh16f7krJyqKmLgPirCEO2EwTTH0Wi2JQEVgccGwXaG6XNj4kRoOV/OgMXhtPY06UD4S8vV855xSFpjh6RmWeNcRr+Ki0OAykNZV6Lq4EfKx0vdMNXWzTuLjnIiUydILXx+5KDTPs3PsCImayV6crVk0bttqpCmywUQWcDrwhoZG76WxFn0NplAgeJViBKeLYZNb1qfEyOQjGN9Kg6nNhgcj2asJMo5LNL3aEtBDnHk9B3SNAaPaA/fVFEihzNEtDiXRRxwDRq0MKl/DlgKpvnuGaXDYC9pj5fbGFh3WyKEnEqyggxuEbSrCxP5qkxD9CJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYNTqH6U5qdVFBbOgyMOi9R+paU/NnIhP2aSEZAE+2g=;
 b=ANYDtJwCT1EGqt4WQlwi0GYANTBTgl7o2/tWy6ZrR+vg/5deYhnWvywJJg+2Tbfv/R48Yxox8KEG+gtihS91eeP1TeLrCnMkGAujeab/KzcHPEAP4RB28/lQYtzAN7FbgCt+PuC8sZRrs9BDMuNCEeuBmu8N6XFLGgc/DNKZXSG11SosU76ZWZ2c3oAzzU/KUGoncVKBY61ZgV/lUOHYp+qtaW+YlY6M3OvaJkZn5qIlGBI9WtUI9OSy7RCVWO6tfwIgeeQ+Zf1Sv+G8J6TJPrjjy446nsh08cBQL3vU+LhSzSJVk3CU+bDNV3j5fs/gbhjg2mRG6qjBi5J3Op0LTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <64aa9a76-c216-060c-7081-c62f9b71bb6f@opensynergy.com>
Date: Fri, 28 Apr 2023 10:31:05 +0200
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
 <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
 <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <630ba79d-aed7-60fb-b7b3-cb1d08b1073c@opensynergy.com>
 <CAPBb6MVWaBHR-d6aqaMXTxuX5ns3RNY4cNJhak5ijoicfTvoAw@mail.gmail.com>
 <4fe9b619-c2b3-fe22-d7ac-b92ffc90a80e@opensynergy.com>
 <CAPBb6MUSKBE+SUEShm4tksaUh6tPE81b5T8_uKAPS_h_Og23dA@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MUSKBE+SUEShm4tksaUh6tPE81b5T8_uKAPS_h_Og23dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::16) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR2P281MB2842:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be35639-7bda-4c77-aeb4-08db47c2ea7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UfFpeTAAwgkVtwYaXk/cfcgX1H5JtlC/AFcJkT2dv3tMOzJnQJhisQRGpNtGHlh5dw5tE/nnuJo+hfNEJBkqQEjZ8GeifTo3BwnXqg/5tiTpeomwo3SG2kh/icyDgFID5eoyZpII3DXvURrTmRdaI82iJkyvABNdL9p1Ie16bsk63N/lR/y/L8n6STbgX6I90il+AI0OcCyVDF21BkkfjK0/Jr+1V+mCKZQwEhp+3i8zzOJU/XkjjqZSb+udUV24l4jMz5IRgMwxLXCn86q4nK7LX14ovESIYk7I2vD/MgyDRXHpiG4GeFss8Gsq2R1h+RphYJLPs0uK7qC2ON79t6d7i4TQwE6ULueeTT+IRGsNKU1eDm20+4CqZHCeWuOKjhQFgtVyPLgeDhNGvZxKJdkLbEotxd507p52/rcQYhACvEs09YgEabWnW2CVkGQBpAoySyUweJSLuV3iWhWL9FTqDCXMDIjZvWJYct/7qbei5KC1Q7jjXedgyW1NNjAkokusQy2rk48Ip5h30vc2U4+F0y/iiK7GqaLArAJAijQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(39830400003)(136003)(451199021)(66574015)(83380400001)(15974865002)(8936002)(5660300002)(8676002)(2616005)(186003)(53546011)(86362001)(7416002)(38100700002)(31696002)(26005)(31686004)(44832011)(66899021)(41300700001)(316002)(6916009)(36756003)(478600001)(42186006)(66556008)(4326008)(66476007)(54906003)(66946007)(2906002)(30864003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Skk2eGRlYi9UQ0NnNzIwUnlaMzc0RHNmNjBTaXNNMzdoNTZFT2JkQXQrVGli?=
 =?utf-8?B?Y2lENkZTNVYyaVplMlJ6b0g2N2NXWFpsRmdrTExMVThFbTJBVWJSdnF5ZDdj?=
 =?utf-8?B?dmZJMWdxUW8wWUZSbWtqMkVvT2VmMU1Pb3ZHV2l6eTJTeHNISktuNFBHRi8z?=
 =?utf-8?B?UUtmcjgybVpkaHA1b3RZcTg2UUE3dWp5YURVbnV6M0RsbHBPZ0hqbTFlM2Jl?=
 =?utf-8?B?aXFpSXA5Q0F4U3BFenFqQyt4R3FhZFdwRUtVcXRiM1Q3b2lDU3FJaDRUVmEw?=
 =?utf-8?B?bC9Bc1dxVHdxNzk4SVhYRnpFK3Bjb3pOdmpFOXkxYWtjdk5WenlreUxKRTR0?=
 =?utf-8?B?Y2ZCQkdiZC9Uc3VmN0llOFRTSXZYbXJNMTh1NFJXK1lOeTNOc1VlcytoSllv?=
 =?utf-8?B?dkJPZEZYb1MzUE41M2ZTNW5rY3lTUzFSenhXVG1jellvMFJxcC92K1pCWFlL?=
 =?utf-8?B?cmFSM3licTV1dkIxYkF6MVRjNGtLc01qeWMvRkhkM3MrdWc2YkdsaVVldmdl?=
 =?utf-8?B?azBab1pSQnJ2aUttbEhjdVJxWVlsZEUrOTN2dXFUaFFmU3psKy90NDhJeUlE?=
 =?utf-8?B?NDBoQzA3NVl1Qy9uSHVKQ3ZaRHVqbVo0REk3NjZ4OXNkdTBJRVFHT1NucTVD?=
 =?utf-8?B?bFAyQWlPV2JTaXlrQkMvNkVTems5dk5VYkEyaHVhUXhQN09yMXNpT1dBRzdk?=
 =?utf-8?B?L3l6R0o0d3ZNTTZ6dWp4N2xDZ3RFYXgyZ2lFaWVpUjhMM3dwUlgwRzZRQlZ1?=
 =?utf-8?B?MGFXbmd5cmdkNTFPTU1JRWdZQ0JJeTQvK3gzaFpDaEY3Rk41WlVacEJwREpD?=
 =?utf-8?B?UmVyZlNkclBadGJENWc0b0w0Tk9WWVBPcDVjdHlHMWUrZkphQ1o3YVgyTExn?=
 =?utf-8?B?TlBHOGo1U2hUY0dUVW8yUmRNMm1ZenZ6VCt5SnVabDlEYmxGQUxMSDZXd25U?=
 =?utf-8?B?aWRLYWRYYU92YUdaaFVFWnQrSFArUTk2VmsrUm5abHU4cVUwSHpSOVpITm1m?=
 =?utf-8?B?NDdSYlZWV0EvOWJDd3pUdU94bjBIL2h6NmZDdUpyUldqL2NjSEFSdnhSdHhl?=
 =?utf-8?B?aHNMa1pPQTNEVHc4dmxieUxLdTRkcFpGa0tUdjVQZTR0VWJiZzY0ODM2Qkxk?=
 =?utf-8?B?WlNSQXJPam9JNkswVnNXdW5yNGVNOGs1aktUVHZCbGk2TVhVZEU4QUVSZ2Qw?=
 =?utf-8?B?a2VndWZGVHg2QTMraUUwenBITEhGR0FpdjFyTEJnU1pjNDNsRmlWZkdxaDJx?=
 =?utf-8?B?QlBDU29hRHUxNEdQcDJpUERyaWV3Yld4U1lUQW5KV2g5dU1NaGRHU2Jrdm1N?=
 =?utf-8?B?dHk3R3oraWhYaWlsNUtFMXJsMllzNi9zMlhsTXNWYkpzcEhhR0FkZFVlQWlZ?=
 =?utf-8?B?UDQrUzA0aGI4Q202TGpETXYwQllkMFhuNUNTMUNLdzVkUUs4STd4blh6Q2Fo?=
 =?utf-8?B?UGM2Tms0WlZjOVo5c2xFWUV5L1ZhKytHL1VVbGE2QzlUbGFpRkI2ZlVQQzc1?=
 =?utf-8?B?anZsOVl3TjNYM0RkVUpTZjd3NVRqb3ZocFI4TlFqekx5dUt2Vm5zL2xGMG5V?=
 =?utf-8?B?Y0phenFQRk5LSTR3WDdMbDR5T242YnFnNUt4RlBjT1ZnemJFa05oYmd6Ymhy?=
 =?utf-8?B?RGE0TVk0dDFVK2ljVEUrODVvTmRDSk92R2F4VlVuaHQzWHlHclVsUENZUi9r?=
 =?utf-8?B?VjhsZ2lwUHYyejZuL05vN0dya3dFdE9HbjUzV0I0WjNyRXhWMXd4Y2lnT3dQ?=
 =?utf-8?B?MUEvbndJSTNvdkpVeWhsQTloSWNEYVlzOG1IVHBZL1E5NTlyd21pNnRlMGN5?=
 =?utf-8?B?Vnd6ZUQwaTBkdXhOSml3SjAzRzVUYUlnOGJ2R04zdUdkMUY2R3pkV3d0Ujd6?=
 =?utf-8?B?RXdQVWZlcUxJNm9Qb3owRk92Wm1ER05sOXRvWStBMW84NHdQZ2dmMFpsQXR0?=
 =?utf-8?B?L2pxZUxzMzRHVzVXRVZxK3hKdkloK28rbGFQMnU5dStadXJpNWEydDN1UGsx?=
 =?utf-8?B?UW9QRXFENy81M1JvVHQvTys5d1pGQkJXOWtYSXZsajBsUE9tVTAvWUt4bG9G?=
 =?utf-8?B?Sm55Q050WnJIaDJxWXBRUjUwRmpXazFBc2lYeUduRklWUVhRdWdveVdvY1lk?=
 =?utf-8?Q?6nr0rrr1Kq7xdGE4GEVTu6iF+?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be35639-7bda-4c77-aeb4-08db47c2ea7e
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 08:31:08.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR5moJGMkbUNQDL+M/lBoeKjBHg7OX8eRSpIO9DRwHDPPvvkdDCTEfDW0OqDuWer7COan4AXz1T3Jf7VA5jKNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2842
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27592.007
X-TMASE-Result: 10--24.913600-4.000000
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
	cmWnU7mqp3eYkKzgWRRjCZKJSZKXgCCul34T6LTHwnYOikQ3oqNj4K1y7OCDGLLbElle9EFwhOs
	HxFg1LjDR7Rr7DRtGHGiRI8V4Xipyk9pYCWkl+yskgwrfsC30tCKdnhB581B0Hk1Q1KyJHtBsf5
	/UXJbVQu1GNZ+sikGUtrowrXLg=
X-TMASE-XGENCLOUD: e907f779-d941-4fc2-93c6-ede719f426bb-0-0-200-0
X-TM-Deliver-Signature: 34B64ED3B130F2D9A77F04BEC8909BDE
X-TM-Addin-Auth: FzCcX+3aehOrIe1Jj/UAZGGkqBmSN6fz35xekGQDNlYY6Oa9Sg0I9o6UrJR
	zYDHIpIwsbCyLgeETt3MTBahVDUVWyowlUZD6x3qj8+xBiMQRLrRpmPW7AN4UU6U/yNbxIstXJ3
	g7b9fiNc32Fac93DV280sYQLeNOqZHgKI3cAl7/ckqmL6Yny0kPAZy0oczAscwzZMlkJTHCHwCG
	ErpP2vaPvCB+VwdU31OQQKKcBUUzf4RMefono6MrekHJyH5crExhMOSVWtpg3nrl4sbStmKOnBw
	7hHJdJLQGucAcWM=.NHerCxXlKFDyrcgsjejhkLLFLpVUfc9/zKvPn0H56ZZL41FVhbmVuM8ITz
	VxmYA2icLZ0pmzEUQFR1rSvURZMi2e+rlhmvTbdWKxjYGkUGFIPot3KYqXkFzh4brSk84UCzgJI
	lnN1XJz/bLai3BM3jyGV36Zn5+dF9Gzb/w5O0fUXQQvKxNC3vxMzoRx11DeBPrQCnB4X94NYHD5
	gE4IifT5h2pHWbxWoUslVJfo3tlYVdHfrlm6Zmk+pLL3JpUrgQY8ODBXxJ1f8UkEtXK/Q++T3xQ
	Qe/GjiCSqTxNOzdLgM/9eRqEMgIscajEDxyteSuzytAhBkXRqmW5y/2G1Aw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 28.04.23 05:24, Alexandre Courbot wrote:
> On Fri, Apr 28, 2023 at 12:12=E2=80=AFAM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 27.04.23 15:23, Alexandre Courbot wrote:
>>> On Thu, Apr 27, 2023 at 12:52=E2=80=AFAM Alexander Gordeev
>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>
>>>> On 21.04.23 06:02, Alexandre Courbot wrote:
>>>>> On Wed, Apr 19, 2023 at 4:39=E2=80=AFPM Alexander Gordeev
>>>>> <alexander.gordeev@opensynergy.com> wrote:
>>>>>>
>>>>>> On 17.04.23 16:43, Cornelia Huck wrote:
>>>>>>> On Mon, Apr 17 2023, Alexander Gordeev <alexander.gordeev@opensyner=
gy.com> wrote:
>>>>>>>
>>>>>>>> OpenSynergy, the company that I work for, develops a proprietary
>>>>>>>> hypervisor called COQOS mainly for automotive and aerospace domain=
s. We
>>>>>>>> have our proprietary device implementations, but overall our goal =
is to
>>>>>>>> bring open standards into these quite closed domains and we're bet=
ting
>>>>>>>> big on virtio. The idea is to run safety-critical functions like c=
ockpit
>>>>>>>> controller alongside with multimedia stuff in different VMs on the=
 same
>>>>>>>> physical board. Right now they have it on separate physical device=
s. So
>>>>>>>> they already have maximum isolation. And we're trying to make this
>>>>>>>> equally safe on a single board. The benefit is the reduced costs a=
nd
>>>>>>>> some additional features. Of course, we also need features here, b=
ut at
>>>>>>>> the same time security and ease of certification are among the top=
 of
>>>>>>>> our priorities. Nobody wants cars or planes to have security probl=
ems,
>>>>>>>> right? Also nobody really needs DVB and even more exotic devices i=
n cars
>>>>>>>> and planes AFAIK.
>>>>>>>>
>>>>>>>> For the above mentioned reasons our COQOS hypervisor is running on=
 bare
>>>>>>>> metal. Also memory management for the guests is mostly static. It =
is
>>>>>>>> possible to make a shared memory region between a device and a dri=
ver
>>>>>>>> managed by device in advance. But definitely no mapping of random =
host
>>>>>>>> pages on the fly is supported.
>>>>>>>>
>>>>>>>> AFAIU crosvm is about making Chrome OS more secure by putting ever=
y app
>>>>>>>> in its own virtualized environment, right? Both the host and guest=
 are
>>>>>>>> linux. In this case I totally understand why V4L2 UAPI pass-throug=
h
>>>>>>>> feels like a right move. I guess, you'd like to make the switch to
>>>>>>>> virtualized apps as seemless as possible for your users. If they c=
an't
>>>>>>>> use their DVBs anymore, they complain. And adding the virtualizati=
on
>>>>>>>> makes the whole thing more secure anyway. So I understand the desi=
re to
>>>>>>>> have the range of supported devices as broad as possible. It is al=
so
>>>>>>>> understandable that priorities are different with desktop
>>>>>>>> virtualization. Also I'm not trying to diminish the great work, th=
at you
>>>>>>>> have done. It is just that from my perspective this looks like a s=
tep in
>>>>>>>> the wrong direction because of the mentioned concerns. So I'm goin=
g to
>>>>>>>> continue being a skeptic here, sorry.
>>>>>>>>
>>>>>>>> Of course, I don't expect that you continue working on the old app=
roach
>>>>>>>> now as you have put that many efforts into the V4L2 UAPI pass-thro=
ugh.
>>>>>>>> So I think it is best to do the evolutionary changes in scope of v=
irtio
>>>>>>>> video device specification, and create a new device specification
>>>>>>>> (virtio-v4l2 ?) for the revolutionary changes. Then I'd be glad to
>>>>>>>> continue the virtio-video development. In fact I already started m=
aking
>>>>>>>> draft v7 of the spec according to the comments. I hope it will be =
ready
>>>>>>>> for review soon.
>>>>>>>>
>>>>>>>> I hope this approach will also help fix issues with virtio-video s=
pec
>>>>>>>> and driver development misalignment as well as V4L2 compliance iss=
ues
>>>>>>>> with the driver. I believe the problems were caused partly by poor
>>>>>>>> communication between us and by misalignment of our development cy=
cles,
>>>>>>>> not by the driver complexity.
>>>>>>>>
>>>>>>>> So in my opinion it is OK to have different specs with overlapping
>>>>>>>> functionality for some time. My only concern is if this would be
>>>>>>>> accepted by the community and the committee. How the things usuall=
y go
>>>>>>>> here: preferring features and tolerating possible security issues =
or the
>>>>>>>> other way around? Also how acceptable is having linux-specific pro=
tocols
>>>>>>>> at all?
>>>>>>> My main question is: What would be something that we can merge as a
>>>>>>> spec, that would either cover the different use cases already, or t=
hat
>>>>>>> could be easily extended to cover the use cases it does not handle
>>>>>>> initially?
>>>>>>>
>>>>>>> For example, can some of the features that would be useful in crosv=
m be
>>>>>>> tucked behind some feature bit(s), so that the more restricted COQO=
S
>>>>>>> hypervisor would simply not offer them? (Two feature bits covering =
two
>>>>>>> different mechanisms, like the current approach and the v4l2 approa=
ch,
>>>>>>> would also be good, as long as there's enough common ground between=
 the
>>>>>>> two.)
>>>>>>>
>>>>>>> If a staged approach (adding features controled by feature bits) wo=
uld
>>>>>>> be possible, that would be my preferred way to do it.
>>>>>>
>>>>>> Hmm, I see several ways how we can use the feature flags:
>>>>>> 1. Basically making two feature flags: one for the current video spe=
c
>>>>>> and one for the V4L2 UAPI pass through. Kind of the same as having t=
wo
>>>>>> different specs, but within one device. Not sure which way is better=
.
>>>>>> Probably having two separate devices would be easier to review and m=
erge.
>>>>>
>>>>> Having two different devices with their own IDs would indeed be less
>>>>> confusing than using feature bits.
>>>>>
>>>>> That being said, the whole point of proposing virtio-v4l2 is to end u=
p
>>>>> with *less* specification, not more. Having two concurrent and largel=
y
>>>>> overlapping approaches will result in fragmentation and duplicated
>>>>> work, so my suggestion would be to decide on one or the other and
>>>>> stick to it.
>>>>
>>>> Hmm, Enrico pointed out, that having virtio-v4l2 would also be good
>>>> because of much better compatibility with Android right now. I don't
>>>> think the specification length should be our ultimate goal. Cornelia
>>>> said, that her ultimate goal is to have a spec everyone is happy with,
>>>> regardless on how we arrive there. Well, I can only say, that I also
>>>> think this should be our goal.
>>>
>>> Try to put yourself into the shoes of someone who needs to write a new
>>> video device using virtio. Oh, there are two ways to do it. This guest
>>> OS only supports virtio-video. But this guest OS only supports
>>> virtio-v4l2. Great, now you need to support two interfaces with your
>>> device, or write two different devices.
>>
>> I think this is a hypothetical issue.
>
> Issues have a strange tendency to become hypothetical when it's
> convenient for you.

I would be happy to discuss some of the hypothetical issues coming from
you, if you agree to discuss hypothetical issue coming from me.
Otherwise let's just focus on less hypothetical ones please.

>> IMO it makes sense to use V4L2
>> UAPI only on Linux host with V4L2 devices + Linux/Android guest.
>> virtio-video driver is already available for Linux. We already know our
>> priorities and limitations, so building a decision tree for a potential
>> device developer would be very easy.
>>
>>>>> * Having two overlapping specifications for video is overkill and wil=
l
>>>>> just fragment virtio (as tempting as it is, I won't link to XKCD). I
>>>>> strongly advise against that.
>>>>
>>>> I think they're not going to create more problems, than virtio-blk,
>>>> virtio-scsi and virtio-fs, for example.
>>>
>>> At least these devices work at different layers, that makes them more
>>> justifiable. virtio-video and virtio-v4l2 are just going to provide
>>> the same API for video devices, only with different structures and
>>> commands.
>>
>> Hmm, I think virtio-blk and virtio-scsi work on the same level, aren't
>> they? They could also say this is basically the same thing.
>>
>>>> The decision can be made like this:
>>>> 1. You have a V4L2 device, you don't need any more processing, just wa=
nt
>>>> it inside a Linux/Android VM =3D> use virtio-v4l2.
>>>> 2. You don't have a V4L2 device, or your host is not Linux, or your
>>>> maybe your guest is not Linux/Android, or you want some extra processi=
ng
>>>> on the host (say you have a third-party proprietary library or whateve=
r)
>>>> =3D> use virtio-video.
>>>
>>> That would make sense if 2. could not be done just as easily by also
>>> using virtio-v4l2, which I believe it can be.
>>
>> I'm sorry, I think a potential developer would just look into V4L2 docs,
>> see struct v4l2_buffer (AFAIU with patches in the spec for the
>> host/guest/object memory types on top) and run back to the cleanliness
>> and simplicity of virtio-video. That's basically my story. :)
>> Iterating on formats in VIDIOC_ENUM_FMT looks quite weird to me too.
>
> I think you will probably end up doing similarly in virtio-video due
> to the dependency between input and output formats that is not easy to
> represent in a single structure.

Yes! I'm already working on this actually. But I'd like to have only two
round-trips over virtio. Not 10+ like with VIDIOC_ENUM_FMT. Do you
agree, that less interactions would be better?

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

