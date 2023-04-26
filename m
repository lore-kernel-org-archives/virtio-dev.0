Return-Path: <virtio-dev-return-12439-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592C4C77B78
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 15:52:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 677283F555
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 15:52:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17CF6986651
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 15:52:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E61FB98662F; Wed, 26 Apr 2023 15:52:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3530986640
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Apr 2023 15:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682524349.369000
X-TM-MAIL-UUID: 2b3b7ef7-d215-45f5-a44c-8604537bdbcc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1spbUSCqVXfmw/6Ck+eX7kdYHH6dwCZB8VZ4NKsrUb47sx5XXbIHql7It6qY3R6mSrSi12r+KzaFvpbpJz/GoT/C8hv5Kna0Ap54WvvzQQJG2V/Hokx47y1JNr1X0PXNtiE7qx6vw63enoZmkr11B8Y7ITTmLOoQ/Gs1E5SotO3rJJ89Y6yc0Vu0HNN/EswSrOdYyHS97heYTU5oBDqk00oNtLdIVPnoIbc7zXU3kKpCt/rfjbp3obAOwsRCuGdtx2629xA2Pk53ZOdHopb4mvl4zFTHcr5Ttw+fQbjgrtF0FDC+Oy7ArNJLDXyQJTn+/W4im8RaihV2gt43WbVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUYl51CtVKTQgzR8FstSirZw3MH727Poh0EJyWapc70=;
 b=e2VdUvT4n2wHok0GLL/Fh2pENaj5Rm936lYbnLTkFqXsMqG5MR6DGOq3uXyFq3Y5T0uZ8eNnvO6icY2v41aKD03+qbKQTB5lciM0J/F4t474tTvgNQIYGge0B+4/DpuFOBDZsWNvwU3MRWlEHnK/qwkmSrmEhgdQPsVjPEsYur716HtjHvBLfEiy7EdmCliDhBNCg43zBrH1qCseXc8fJv509JssmO/4GqAs71UQhxPUpCMt1BDagMppnBJLBDU9RsFZX1Nv2/C3wlWC3Mt9L3wkPswp7BmLkl9CfWYtHZlzJOr9sh4YR9e6SYCMsXfXd4BHDD6ql37KuO6rI6gsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <630ba79d-aed7-60fb-b7b3-cb1d08b1073c@opensynergy.com>
Date: Wed, 26 Apr 2023 17:52:23 +0200
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
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
 <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::20) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR2P281MB3136:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a8592d-b126-46d2-29dd-08db466e3c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RdL3dth4aGzKfPeRispe048NlwZT7gac+CZAb7JyNvqO1NBzf5WUvrKzfvLgC6oh0PgtbJudej9cUHp5y7JBRBjhytN5jHKRm6MA42eampdyuOplOl0dC4hAnyR+IiyvExKVj3r7bEXb7axkn5Stt+XAP6d+2SA+aiEt7wwde7fUHw/9GApYgGn+75uDP73rfOKwgZZpqd1YdCpS47fOJVD6e1BV2KKwFShjGu8rcn5yNRln3dU2Y0kslWB7ms5UOWPr9QOKVev4s1XDfSewUYU1Av9eycgkT+VokiaaQN0C2FKHqx2PEkQnRSMOGf/FdCmrsyBk15qjWD0W53RrytYo4IQH5b2RKS223+ufJaPEBbKcAy/QVeYbp/iPMIqGAu3dUMUDi3tVRsORHdK3J0DTU8VU+ZlsgvioK3VOGP+XsSPT4npWvKtc6/U11B2uwfcXPUNU3bCRnVo9tRMK2zSWvNBpCZln0uo06B2OD8gU76fIZmccAGdgnmnn+dtyDDnR93SURdZDVYqjr8GRD4J9aAz8sHuNOKdWqNMeca0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(136003)(346002)(376002)(396003)(366004)(451199021)(54906003)(2616005)(66574015)(83380400001)(478600001)(31696002)(26005)(966005)(6916009)(41300700001)(316002)(66556008)(4326008)(42186006)(53546011)(186003)(31686004)(66946007)(66476007)(5660300002)(7416002)(44832011)(8936002)(2906002)(30864003)(66899021)(38100700002)(86362001)(8676002)(15974865002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czI3c1l6RXJJa1dKZ0RKbGwxNnlXRGY5K3NpREk5b1VYbzJUSHpYVXNyQXhB?=
 =?utf-8?B?NEtFc0V4R1ZpYzFDcjQvbng1SGZobDFqWG5WUk5ZdTlaMlRHT1VNSUNQVDZQ?=
 =?utf-8?B?WXZza1M2aG9xeThPSXRoZk9lalJ6UStLYWRGMW9BZG9GV0pCTjF1SVRVdUJj?=
 =?utf-8?B?TTlYdFRxVnEreXBEZXRRQVN2bjZLUnBQSU1MUUtLRXAvOGQ5OXlaSHczU0FW?=
 =?utf-8?B?TERaSVRXNDFsNXhvMVdhOU44bXd0OCtUVHRxT2krV09ZSDhLUmFReGlUSlhx?=
 =?utf-8?B?M0lQbXoxWUxSNXhlaFM2N1IwcjNIM01GUit2UExBbHJ2Q1V2SU0ySHNQNG00?=
 =?utf-8?B?eDIzQVNmdUc4VXA2UmwwSWUxN2wyR3dKMkh1M0VoV3pYcFAvL1VtMDVtSnU1?=
 =?utf-8?B?VkRtRm5jaDFKV3UrNml0WHo0aEZpUlRZQXZvSWwyZURhRXhqU3lBTy9FM1Nr?=
 =?utf-8?B?L2dPa240V1o4NkFTdE9LbmExUGJRb3RaNE9zSE1RUkM0YWtCNFdQWTNLbXJ3?=
 =?utf-8?B?MnNMS0xXc1gyTzdYOFNBeHY5b0FQRzhpMXhnTVVwYzFsSHVmc2ZaclJJdExv?=
 =?utf-8?B?bFdPcnA3dGdLWlVyc2RKaG1nd3g1MTJ3VzF5Slp5VW4zOHBweEJmWHovUE9G?=
 =?utf-8?B?TmFhUThxc25tek5seFhweVhRdTdMcVlRUWJuU0xBOEVQVkFDQ0RjSzVjMkEv?=
 =?utf-8?B?aDFHS1dNRVA4bDc1bnorNXZDak5XdFNiYlFrcG5hS0s5elJ5YkswQU03ZTFa?=
 =?utf-8?B?U2UzVVdaK3NJbzV3NnlRbWlnRzdMSWQvMjRiNzJxbTI2bGN5WDB5ZHRKVEVY?=
 =?utf-8?B?MlBCdEc5L0RmbGtBSlNGeURaZXZWQzcrbFdXekozMlVMWkFUZ3FaTXZkZk9M?=
 =?utf-8?B?TS9oM1cyd1kzTWNJZmZJZm90SmNRQVJtVVpyWWJyald5YnY0SFdrTEhLNTBw?=
 =?utf-8?B?REs3NWpKanNYK2M3clpHdUtKUXFiMWl0bWhrcGNZNlYwNTRkaFhqMXh4ZXlX?=
 =?utf-8?B?QjJQQUM4bjQ2ZGVtMG1ZL2VaWHUwaUFTbWFVQ2NRSkRkelk4SkJqZDVQQkFU?=
 =?utf-8?B?cTBDTlVldVhBN2JiZUpjWEdMcUpkY2ZkdGR6Y2phMHh1ei83Tnd6Vmk2MkJD?=
 =?utf-8?B?cjJZME94Tkt3VUNZN3k4V3RJdzZReVd6OVhwTnJpTWw0eThSdmlCZ0QxTXBF?=
 =?utf-8?B?QnF4UkhJa00xN3ZyM21SaHNjdEJnSVRQcXpoTnhSVi94RlFkL2hkZjZzcUJq?=
 =?utf-8?B?N0VLOEJ3OEZWWXloamp0S3ZiS1BuOGx3YW1KeHlSS2xSUXVHWVNia0xvY2Zz?=
 =?utf-8?B?aTYwRTlFQWZneFlSOEFmNy81ODlRck5CNGNKKy93cGd6Q1QvWnBNVzBaRzR3?=
 =?utf-8?B?QlNlKzA4Y0dvanFNOHFxTWJhdVNkdTVjYy9LSmtCeG9Bb0J5UUcrOG5mTmpN?=
 =?utf-8?B?Wjc4ZWFCM1dGd1ZaN1FzNVhwTlZZNVNKV0s0Qkg5ZTNqYTJ5R3o2V1ZrbDRu?=
 =?utf-8?B?MHVDdGlKNjkwNlNCNkpYSm5VcDJFK1VucnV5d2taMjIzSnlwSUZPejJ4N2hq?=
 =?utf-8?B?VHhQejZjWU5ORTBGWkhFWWl2TE1Pekt0V0poVEgzM1NvdlZuREVmSXpndjVy?=
 =?utf-8?B?U1d3TkEySFU5TUcvc1loeUd0UXZ3MW9rSGpWKzg2cnc2Y1c2NmcrRjFFak1G?=
 =?utf-8?B?MUNLbEZXVHJTTnBrY1lBSC9iYnkwVHdVcit4MDNwY1J3YmtNWEt4OXgzZUdW?=
 =?utf-8?B?UTZZR1RhcDdqaVQwbDhGR0V4MWRha0JucS82T3NZYzRYQ1M5OXh5TTgwTVhY?=
 =?utf-8?B?T2wyVzF1eU13U1BScXhIeWphWkZ5akRyKzFqL3dESWpjMFlsZDEweGdJUnBh?=
 =?utf-8?B?bmZJZGVrTlBjTWhwWTN0L2dQREdRVHFGd1BFVEh1eENXZENtN1E5cXRGMGNn?=
 =?utf-8?B?WHhhME5NaGllS05pQVZkOEwwNXpIb3RQbGpud1VNZUI3a2VXY1dPcXZXM29S?=
 =?utf-8?B?SGVmU3NtTzEwOTIrTXZoQThCOHVvWE9Hc1dwRXhCMDZFekN2SnhsaGZHZVc2?=
 =?utf-8?B?czJpSms3SU1jL2g5Wk1tQkQvV3p6TW1PSE1rQ0ZJNWovNnRNeFBoMG5aanRi?=
 =?utf-8?Q?bn74le7KKSD57Xw9iOv2iTbEQ?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a8592d-b126-46d2-29dd-08db466e3c54
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 15:52:27.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZZUcE1qASdcjG9Fp5PhEaWM9C/lSjVDGDn8ZWI4kgsudGF3FmG0B4pxsRcE956k3g3Jr/iuULkMY8cmS/Lliw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB3136
X-TM-AS-ERS: 104.47.7.177-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27590.000
X-TMASE-Result: 10--28.354200-4.000000
X-TMASE-MatchedRID: hFbMlnd2lLORIcMttWNNnDRvbUTEU3b6rmLeMrcoM6gL8TGleseLPB/T
	HH4EgJNXOXB2cqV0mCK2nJIymOSHNTAAk8j+D63T3BPrPGHYpyMRW4LR41Fi8oHK2QhtcJsHBFB
	ELUK022eRWoMGf/8eEj1U0pjCxwxwCeeBbUlZyWrYEhFHE+qJehqkhv3OdF4Dp7k0ULYOTsWhSG
	4odLP+NsU4n9V0lkG1FUQlkTtf7Zh/WxxIgeiTHitUrv+PRgdc3u5w3Ea2Xmgcsx3IH4sq3NZ5C
	2tydwt9KlbG+C+eP5qQ6tag/ox2gDwSas/EhcgS6j3wrZ/kERdruPKJRNQw6Cpykp1AmBYaJKKi
	zfyRZ3FacIFsLrAMEr/WX02co7bcg6VO9s8e6fnaVLFZNmNGNMp9Bgr5ONKhmdrHMkUHHq+GD9O
	3ui1h2Mu3fu7mGETZgRXUy3f9jsQYEcIhk1iI+SXNLhdJ/ZwuX9knSHW8uXV0bXWCb2qGLpr58C
	ksHfm3t3YGUcAiLMU67N42Y4Yqc1Y7maOxI4yf1vw2PCSYC/oASCpNzgtLhPWr7HvOSElaP4H+2
	nyK0FMF12zhTSR9X/Hv2a4cQYCLtgp/mSQ1GlVpY+rDpJtqXlaxq6bEGGO0twpUiv21DA1uS8Am
	g5D32TEajc3/zVQVRen9gl6ABVVg2TjPfw834xv5JCEP9OqSZEKL9WloxNesGE6m/DpJi7RNETN
	/KlSa8cLCH9VtgHtlFSORUVE4XmEtMujR9T//Xd2C0i9IY+ncnfzpNQnhvJPd/WqnvA114TWlih
	dnJ0FnyyhFu6pbB6yN4ydJoo/6swEY+Cv3V2ieIHQ/s2c37p4CIKY/Hg3AWQy9YC5qGvy2s0ar5
	ZAS9BrmtQCHIUNQC24oEZ6SpSkgbhiVsIMQK2u5XqFPzjIT8jF0kHc8YvQ=
X-TMASE-XGENCLOUD: c2240781-b163-45bd-93b8-4eff08dae4f8-0-0-200-0
X-TM-Deliver-Signature: 103D3F99CCF6402B62181E7EB0E79320
X-TM-Addin-Auth: IgUlcLoz6Dn6otX1tYEpr0C77c2/sKB6gIe2tLLzskh89iD75w8SGdwO68D
	ITwUaZj9MGpU3oy2qpz4jHAufrOnVlmokgX9PMocLH4w8xb6qlG/9D3SCAzUY70Qrfpc0n96EZI
	LnXJAtgCItpI8gJFjpDRNPQ9NYH+DDf6NJifxJA5Ey/CnLIqT8MPpDK+nzEebqqA3clsLkd4Pvy
	mwjXQ3HwJUZcEAPj0pYsrN7sthPNbKq+iGf5kXaKXLligED5LHi4BDpw0D89mD2htISq/bgkq8M
	CfF+6rp9WBt14P8=.2DJMbgbaWb/6Hbbhu6uWPEaQm4zma3cqOjkRHTdnydx4PRn8iJzKsNnFQj
	PSINLe6RKH25HghwY9cWufBf6bnVJbEJ47xdSkHvh9Foe8XtLUJxLFqlnLipbXshuQuG5K3VSik
	v3FCe9FydNTR2m8vuTfG2pO0i/suWmVRiCScJ5AzxDuARVSZ2f9oIAvovHn70VcPi9QFlmtXIMD
	EZxwMkH7QpE5qu+/rVF+8k2uS2gxmQUMswUncYpyswQBkoiFh3f2OJasHuUa5NJibLZUcIFYbOj
	TZT9yJAVMIQbaAkAVBn8cA0cegMWTbE/DthK/BqqXLZbVrpAiWWqCQjtHRw==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 21.04.23 06:02, Alexandre Courbot wrote:
> On Wed, Apr 19, 2023 at 4:39=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 17.04.23 16:43, Cornelia Huck wrote:
>>> On Mon, Apr 17 2023, Alexander Gordeev <alexander.gordeev@opensynergy.c=
om> wrote:
>>>
>>>> OpenSynergy, the company that I work for, develops a proprietary
>>>> hypervisor called COQOS mainly for automotive and aerospace domains. W=
e
>>>> have our proprietary device implementations, but overall our goal is t=
o
>>>> bring open standards into these quite closed domains and we're betting
>>>> big on virtio. The idea is to run safety-critical functions like cockp=
it
>>>> controller alongside with multimedia stuff in different VMs on the sam=
e
>>>> physical board. Right now they have it on separate physical devices. S=
o
>>>> they already have maximum isolation. And we're trying to make this
>>>> equally safe on a single board. The benefit is the reduced costs and
>>>> some additional features. Of course, we also need features here, but a=
t
>>>> the same time security and ease of certification are among the top of
>>>> our priorities. Nobody wants cars or planes to have security problems,
>>>> right? Also nobody really needs DVB and even more exotic devices in ca=
rs
>>>> and planes AFAIK.
>>>>
>>>> For the above mentioned reasons our COQOS hypervisor is running on bar=
e
>>>> metal. Also memory management for the guests is mostly static. It is
>>>> possible to make a shared memory region between a device and a driver
>>>> managed by device in advance. But definitely no mapping of random host
>>>> pages on the fly is supported.
>>>>
>>>> AFAIU crosvm is about making Chrome OS more secure by putting every ap=
p
>>>> in its own virtualized environment, right? Both the host and guest are
>>>> linux. In this case I totally understand why V4L2 UAPI pass-through
>>>> feels like a right move. I guess, you'd like to make the switch to
>>>> virtualized apps as seemless as possible for your users. If they can't
>>>> use their DVBs anymore, they complain. And adding the virtualization
>>>> makes the whole thing more secure anyway. So I understand the desire t=
o
>>>> have the range of supported devices as broad as possible. It is also
>>>> understandable that priorities are different with desktop
>>>> virtualization. Also I'm not trying to diminish the great work, that y=
ou
>>>> have done. It is just that from my perspective this looks like a step =
in
>>>> the wrong direction because of the mentioned concerns. So I'm going to
>>>> continue being a skeptic here, sorry.
>>>>
>>>> Of course, I don't expect that you continue working on the old approac=
h
>>>> now as you have put that many efforts into the V4L2 UAPI pass-through.
>>>> So I think it is best to do the evolutionary changes in scope of virti=
o
>>>> video device specification, and create a new device specification
>>>> (virtio-v4l2 ?) for the revolutionary changes. Then I'd be glad to
>>>> continue the virtio-video development. In fact I already started makin=
g
>>>> draft v7 of the spec according to the comments. I hope it will be read=
y
>>>> for review soon.
>>>>
>>>> I hope this approach will also help fix issues with virtio-video spec
>>>> and driver development misalignment as well as V4L2 compliance issues
>>>> with the driver. I believe the problems were caused partly by poor
>>>> communication between us and by misalignment of our development cycles=
,
>>>> not by the driver complexity.
>>>>
>>>> So in my opinion it is OK to have different specs with overlapping
>>>> functionality for some time. My only concern is if this would be
>>>> accepted by the community and the committee. How the things usually go
>>>> here: preferring features and tolerating possible security issues or t=
he
>>>> other way around? Also how acceptable is having linux-specific protoco=
ls
>>>> at all?
>>> My main question is: What would be something that we can merge as a
>>> spec, that would either cover the different use cases already, or that
>>> could be easily extended to cover the use cases it does not handle
>>> initially?
>>>
>>> For example, can some of the features that would be useful in crosvm be
>>> tucked behind some feature bit(s), so that the more restricted COQOS
>>> hypervisor would simply not offer them? (Two feature bits covering two
>>> different mechanisms, like the current approach and the v4l2 approach,
>>> would also be good, as long as there's enough common ground between the
>>> two.)
>>>
>>> If a staged approach (adding features controled by feature bits) would
>>> be possible, that would be my preferred way to do it.
>>
>> Hmm, I see several ways how we can use the feature flags:
>> 1. Basically making two feature flags: one for the current video spec
>> and one for the V4L2 UAPI pass through. Kind of the same as having two
>> different specs, but within one device. Not sure which way is better.
>> Probably having two separate devices would be easier to review and merge=
.
>
> Having two different devices with their own IDs would indeed be less
> confusing than using feature bits.
>
> That being said, the whole point of proposing virtio-v4l2 is to end up
> with *less* specification, not more. Having two concurrent and largely
> overlapping approaches will result in fragmentation and duplicated
> work, so my suggestion would be to decide on one or the other and
> stick to it.

Hmm, Enrico pointed out, that having virtio-v4l2 would also be good
because of much better compatibility with Android right now. I don't
think the specification length should be our ultimate goal. Cornelia
said, that her ultimate goal is to have a spec everyone is happy with,
regardless on how we arrive there. Well, I can only say, that I also
think this should be our goal.

>> 2. Finding a subset of V4L2, that closely matches the current draft, and
>> restrict everything else. A perfectly reasoned answer for this case will
>> require a lot of work going through all the V4L2 structures I think. And
>
> It's pretty trivial, on the contrary. For a decoder device one would
> just need to restrict to the structs and operations mentioned here:
> https://www.kernel.org/doc/html/v5.18/userspace-api/media/v4l/dev-decoder=
.html

I don't agree. But we already talk about this in other threads.

>> even if we have a concrete plan, it has to be implemented first. I doubt
>> it is possible. Based on the things, that I already know, this is going
>> to be a compromise on security anyway, so we're not happy about that.
>> More on that below.
>> 3. Stop trying to simply pass the V4L2 UAPI through and focus on making
>> the virtio video spec as close to the V4L2 UAPI as possible, but with
>> the appropriate security model. So that the video device can be extended
>> with a feature flag to something very close to full V4L2 UAPI. A lot of
>> work as well, I think. And this won't allow us to simply link the V4L2
>> UAPI in the spec and therefore reduce its size, which is Alexandre's
>> current goal. So Alexandre and his team are not happy this way probably.
>
> That would indeed be reinventing the wheel and a completely pointless
> exercise IMHO.

I agree.

>>   From the security point of view these are our goals from most to less
>> important AFAIU:
>> 1. Make the device secure. If a device is compromised, the whole
>> physical machine is at risk. Complexity is the enemy here. It helps a
>> lot to make the device as straightforward and easy to implement as
>> possible. Therefore it is good to make the spec device/function-centric
>> from this PoV.
>
> This seems to be the main point of contention we have right here. I do
> not believe that V4L2 introduces significant complexity to the video
> use-case, and certainly not to a degree that would justify writing a
> new spec just for that.

Ok, then we should try to agree on a benchmark, I think.

>> 2. Ensure, that drivers are also secure at least from user-space side.
>> Maybe from device side too.
>
> FWIW V4L2 has been in use for a looong time (including in Chromebooks
> that do secure playback) and I am not aware of fundamental security
> issues with it.

Already being discussed separately...

>> 3. Implementing secure playback and making sure media doesn't leak. For
>> this case it is nice to have these object UUIDs as buffers.
>>
>> Please correct me if there's something wrong here.
>>
>> When we start looking from this perspective even things like naming
>> video buffer queues "output" for device input and "capture" for device
>> output are problematic. In my experience this naming scheme takes some
>> time and for sure several coding mistakes to get used to. Unfortunately
>> this can't be turned off with some feature flags. In contrast virtio
>> video v6 names these queues "input" and "output". This is perfectly fine
>> if we look from the device side. It is understandable, that Alexandre's
>> list of differences between V4L2 UAPI and the current state of virtio
>> video doesn't include these things. But we have to count them, I think.
>> That's why it takes me so long to make the list. :) So throwing away
>> this simplicity is still going to be a compromise from the security
>> perspective, that we're not happy about.
>>
>> This is mostly because V4L2 UAPI brings a hard dependency on V4L2, its
>> security model, legacy, use-cases, developers, etc. It can be changed
>> over time, but this is a long process because this means changing the
>> Linux UAPI. Also this means, that nothing can be removed from it, only
>> added (if the V4L2 community agrees). For example, we can't simply add a
>> new way of sharing buffers for potential new use-cases once we switch to
>> V4L2 UAPI AFAIU.
>
> You certainly can, it would just need to be in the virtio
> specification. And again that's a very hypothetical case.

Ok, maybe it is hypothetical.  We won't know until it happens. I still
don't like it. Overriding things in the virtio specification is not
particularly nice. It is much easier to understand when things are kept
together, not as patches.

>> The V4L2 community can simply reject changes because
>> this is a UAPI after all. We kind of have a weak dependency already,
>> because the only driver implementation is based on V4L2 and we'd like to
>> keep the spec as close to V4L2 as possible, but it is not the same
>> thing. So at the moment it looks like the V4L2 UAPI proposal is not
>> super flexible. Alexandre said, that we can simply not implement some of
>> the ioctls. Well, this definitely doesn't cover all the complexity like
>> the structures and other subtle details.
>
> Mmm? Where did I say that? That sounds like a misunderstanding.

Here is the quote from your email on March 17:

> V4L2 has a larger UAPI surface because it manages more kinds of
> devices, but drivers only need to implement the ioctls they need. For
> the rest, they just return -ENOTTY, and evil actors are hopefully kept
> at bay.


>> Also adding the feature flags would probably defeat the stated purpose
>> of switching to V4L2 UAPI anyway: the simplicity of the spec and of the
>> V4L2 driver.
>>
>> So I have a lot of doubts about the feasibility of adding feature flags.
>> If Alexandre and his team want the V4L2 UAPI as is, then looks like it
>> is best to simply have two specs:
>> 1. virtio-video for those interested in building from ground up with the
>> security model appropriate for virtualization in mind. This is going to
>> take time and not going to reach feature parity with V4L2 ever I think.
>> I mean some old devices might never get support this way.
>> 2. virtio-v4l2 as a shortcut for those interested in having feature
>> parity with V4L2 fast. Like a compatibility layer. Probably this is
>> going to be used in linux host + linux guest use-cases only. Maybe it
>> gets obsoleted by the first spec in several years for most modern use-ca=
ses.
>>
>> Or maybe have these two cases within a single device spec as I wrote abo=
ve.
>>
>> This makes a lot of sense to me. If V4L2 UAPI pass through is in fact
>> only needed for compatibility, then this way we can avoid a lot of work
>> going through all of the V4L2 and trying to find different subsets or
>> trying to construct something, that is close to V4L2 UAPI, but doesn't
>> compromise on the security. I'm not really interested in doing all this
>> work because we're already more or less satisfied with the current
>> state. We don't need feature parity with V4L2. On the other hand for
>> Alexandre the feature-parity with V4L2 is clearly of higher priority,
>> than all these subtle security model differences. In my opinion it also
>> doesn't make sense to invest that much time in something, that looks
>> like a compatibility layer. So it seems both of us are interested in
>> avoiding all this extra work. Then I'd just prefer to have two different
>> specs so that everyone can work according to their priorities.
>>
>>
>>> Regarding the protocol: I think Linux-originating protocols (that can b=
e
>>> implemented on non-Linux setups) are fine, Linux-only protocols probabl=
y
>>> not so much.
>>
>> Thanks for the information. Well, it looks like the V4L2 UAPI could be
>> implemented on any platform unless it needs a completely new way of
>> memory management since all the V4L2_MEMORY_* constants are going to be
>> used already AFAIU.
>>
>>
>>>>>>       a. So V4L2 subsystem and the current virtio-video driver are a=
lready
>>>>>> reducing the complexity. And this seems as the right place to do thi=
s,
>>>>>> because the complexity is caused by the amount of V4L2 use cases and=
 its
>>>>>> legacy. If somebody wants to use virtio-video in a Windows guest, th=
ey
>>>>>> would prefer a simpler API, right? I think this use-case is not pure=
ly
>>>>>> abstract at all.
>>>>> The V4L2 subsystem is there to factorize code that can be shared
>>>>> between drivers and manage their internal state. Our target is the
>>>>> V4L2 UAPI, so a Windows driver needs not be concerned about these
>>>>> details - it does what it would have done with virtio-video, and just
>>>>> uses the V4L2 structures to communicate with the host instead of the
>>>>> virtio-video ones.
>>>> It can also reuse the virtio-video structures. So I think despite the
>>>> ability to reuse V4L2 structures, having to implement a linux-specific
>>>> interface would still be a bigger pain.
>>> Hm. Do the v4l2 structures drag in too many adjacent things that need t=
o
>>> be implemented? Can we match the video-video structures from the curren=
t
>>> proposal with some v4l2 structures and extract a common wrapper for
>>> those that match, with a feature-bit controlled backend? It would be
>>> fine if any of those backends supported a slightly different subset of
>>> the common parts, as long as the parts implemented by both would be
>>> enough to implement a working device. (Mostly thinking out loud here.)
>>
>> I don't think this is realistic unfortunately. On per ioctl level it is
>> possible to disable some functionality probably, but the V4L2 structures
>> are set in stone. We can only extend them.
>>
>>
>>>>> The guest driver that I wrote is, I think, a good example of the
>>>>> complexity you can expect in terms of guest driver size (as it is
>>>>> pretty functional already with its 1000 and some LoCs). For the UAPI
>>>>> complexity, the host device basically unpacks the information it need=
s
>>>>> and rebuilds the V4L2 structures before calling into the host device,
>>>>> and I don't see this process as more complex that the unpacking of
>>>>> virtio-video structs which we also did in crosvm.
>>>> Unfortunately our hypervisor doesn't support mapping random host pages
>>>> in the guest. Static allocations of shared memory regions are possible=
.
>>>> But then we have to tell V4L2 to allocate buffers there. Then we'll ne=
ed
>>>> a region per virtual device. This is just very tedious and inflexible.
>>>> That's why we're mainly interested in having the guest pages sharing i=
n
>>>> the virtio video spec.
>>> This really sounds like you'll want a different approach -- two
>>> mechanisms covered by two feature bits might indeed be the way to go.
>>
>> Well, basically this is the way we have it now. I'm not sure what is
>> Alexandre's plan with the V4L2 UAPI approach. And if this is going to be
>> solved, the solution already doesn't look future-proof anyway unfortunat=
ely.
>>
>>
>>>>> I hope I have somehow addressed your points. The main point here is t=
o
>>>>> discuss whether the V4L2 UAPI is a suitable transport for guest/host
>>>>> accelerated codec work, regardless of what the guest or host
>>>>> ultimately uses as UAPI. The goal of the PoC is to demonstrate that
>>>>> this is a viable solution. This PoC is largely simplified by the fact
>>>>> that V4L2 is used all along the way, but this is irrelevant - yes,
>>>>> actual devices will likely talk to other APIs and maintain more state=
,
>>>>> like a virtio-video device would do. What I want to demonstrate is
>>>>> that we can send encoding work and receive a valid stream, and that i=
t
>>>>> is not costly, and only marginally more complex than our virtio-video
>>>>> spec attempts.
>>>>>
>>>>> ... and we can support cameras too, but that's just a convenient
>>>>> side-effect, not the ultimate solution to the camera virtualization
>>>>> problem (that's for the camera folks to decide).
>>>> Thanks for your answer!
>>> Thanks everyone -- do you think the "two feature bits to cover differen=
t
>>> approaches, but using a common infrastructure" idea could work? If yes,
>>> I think that's the direction we should take. If we can implement this
>>> with just one feature bit, that might also be a good route to extend it
>>> later, but I'm not familiar enough with the whole infrastructure to mak=
e
>>> any judgement here.
>>
>> Thanks for your suggestions. Hopefully we end up with a good solution.
>
> To summarize my position:
>
> * I am still not convinced that V4L2 is lacking from a security
> perspective. It would take just one valid example to change my mind
> (and no, the way the queues are named is not valid). And btw, if it
> really introduces security issues, then this makes it invalid for
> inclusion in virtio entirely, just not OpSy's hypervisor.

Already being discussed separately...

> * Having two overlapping specifications for video is overkill and will
> just fragment virtio (as tempting as it is, I won't link to XKCD). I
> strongly advise against that.

I think they're not going to create more problems, than virtio-blk,
virtio-scsi and virtio-fs, for example.
The decision can be made like this:
1. You have a V4L2 device, you don't need any more processing, just want
it inside a Linux/Android VM =3D> use virtio-v4l2.
2. You don't have a V4L2 device, or your host is not Linux, or your
maybe your guest is not Linux/Android, or you want some extra processing
on the host (say you have a third-party proprietary library or whatever)
=3D> use virtio-video.

The more I think about that, the more sense it makes to me...

> * If the goal is to provide a standard that is suitable and useful to
> the greater number, then we shouldn't downsize the benefit that
> virtio-v4l2 brings to Linux guests.

Please see my comments above about our goals. I think virtio-v4l2 +
virtio-video would be suitable and useful to even greater number of
users, than virtio-v4l2 only.

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

