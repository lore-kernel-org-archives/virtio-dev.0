Return-Path: <virtio-dev-return-12747-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5530C77B75
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 11:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D71642AC5C
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 11:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DACD9865ED
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 11:05:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0E2A6986343; Wed, 17 May 2023 11:05:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD2B8986369
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 May 2023 11:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1684321448.112000
X-TM-MAIL-UUID: 2f652bb6-03d3-4443-9322-5eb72cec0e7f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9/dPC3a1RfjcpKHJGnM1cxh3hDiCpIV/2QyonikWjqlWan0UO9T5x7T92Aavg++2C/GyxVCn65e9zHdwuE2CqjaiVF7BD2PGfFyM9cUWa4fggcZ2FMhrSAfq4fZLzJdq2owwMOEZDIN+21KfB+WCpFKhUdWjKAv3Aax2vIezFEDYwPw/TzD26hBlERt6hfDwUFFuWHogF9bnbX3XFKJ5QOiINJvudKbbZ3O/B/eGcAxd0CrrfGrcdvEQUqvLUk8ROqKzYFfKYhtyz7k9KGnj4f4ZL8C0cb3qlIye9gA1hNQ9JxspJeiRT5FvW0SAU6HPJkSzklokIzFEMCB9kEGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcHfkYYcOxYVizQRGAi5e3wuy8nOR6agjtzdUoogsAI=;
 b=GkBAl88FwMmcZl/Z/PgAwgPEnLc/+epDWpt6MPxGO+YwoBI3Cv+Xfbh9X0MygyTXfVKBtcOXdrgBCh19EhiSsf/NW9v+Ejq3+2Ob9bpVfkd//yzeckArzs2eAaT3HX0fSTZC3hRErDgPnH4+IVIpTpZoiLA/GbFXZVTb2VY7a1xFYJEpiK6h82PclhLNqMl9/fGCU7kUCGdjGXvmMqegkvPQD4KzPujCDr7zn3kYdCd1T8L4r8dDuTNzgFHZ9As2G/QSo2CGenYetpzWME47ozyc8R/coKHAGhyngi513otKSPsG8nxtLvxvJ+8uctUC5TYh1wKmg4sJvVQjJ65bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <7d745243-1796-150b-3cf0-e43679611cca@opensynergy.com>
Date: Wed, 17 May 2023 13:04:03 +0200
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
 <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
 <CAPBb6MXGk-j9_hdU0DCSWoo=cUOFSxRjmLyoXObC8u2BmKeRdg@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MXGk-j9_hdU0DCSWoo=cUOFSxRjmLyoXObC8u2BmKeRdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE0P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::17) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR2P281MB3374:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9eae4d-4b91-4979-8b75-08db56c66ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EjD+bjTDocRdarMVUK5lJ49ymKe7vPjifRRpjCTtQk2nve1kN7+nwl6VV2grBJ3Ql+sV/ysnwbbrlPCm4C0grpT1ACPYPZyHLHRMongYW5YBtuR9tCEYd2iwAGamUBhej1lmA80hoelpGxixVuAJ7RcskVAIZZ+euKDJtK32YD61AXZA2FiEDX0Im4jGtgzycCzGoEPmPMxxBZ4XT4GYGo8B1fGB2sb9VqKoY0CsMXc/i1DVAqpVe3IlMkhvODuhrNXzf/vYXO33H9YRkebR/FFTa9yEiCGBLy5iu0jIED9BDoPVRt99RpCKAJ9OT/KwVNFiUfEGOmELfxWVujFQ3zTqzbrpwasK6i/fyEg1kSJirW6TvD6EDn1g+YK5l/WOcCjNLlWFB/b8x5sMhOrn5nJIJLcQlClSdebTNF+N9ldCRUdQ2nu8Ykxp80HWR2M8s4Uw3ieIaNdHSWdb9bJDJFjUbSKvAA6y1qQp+kgdJDqgX6tti+Caa5+c/W05dmGz783Yy5LhGpOMuIDEMNyFop5fxvod5bcz1tXKvqvatek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39840400004)(451199021)(5660300002)(8936002)(8676002)(7416002)(44832011)(66574015)(26005)(53546011)(86362001)(2616005)(31696002)(186003)(83380400001)(38100700002)(66946007)(478600001)(36756003)(4326008)(6916009)(15974865002)(66476007)(41300700001)(66556008)(316002)(42186006)(54906003)(2906002)(31686004)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVcwTUliZ2lwOWwyVnVPTmJEVVh1MTYyYytnRDRvNm5ycEN0eVM1Qjk1Z2Vr?=
 =?utf-8?B?ZWpGMmg4Wm5XTG5iWE03bG1PSVFkcklkR2VhQm1qd3Z1QklNVVgxKzJFUlRj?=
 =?utf-8?B?MS9EWEJLZ2RQa2ZMbHBFU1pwZmFiMGZBTW1HYm04SFdhSzBGdjQ3bEU5aXhZ?=
 =?utf-8?B?Vzk3KzNCaXYweGlTVVg4WWNlRFpieElFT0toNEp1TEtUMXVNb0VNdGhGSjNs?=
 =?utf-8?B?VHlTd0pvenRrZm10c1lGblhqNURqNzBnVjB6bnlSQU9NcnRyUHd3YzNOMTRx?=
 =?utf-8?B?anNDdUZaQlNkVXVsSzFjNy93NTNJZWhQYzNreSt0RHN1M0lGZytSc2JVbWU0?=
 =?utf-8?B?b2JDUDVVSFNlRHdHbXR3U1htQVBVa2hLYXpTWS9oVWFsSHJ1L2NnTEU5VEVM?=
 =?utf-8?B?UVlpVFRJSnVVR2k1NVgzRXY5Y0ZVKzVFUzRLOUtJaERoaUx4UkIzOUFoZVI1?=
 =?utf-8?B?UlBkK1l4T2ovRldsT3RTa3c5NzR2VzJEN0l5RHY5WCsyUVFnanMwdmNNWVFu?=
 =?utf-8?B?Z3ByR0RZTW1BdkZONW1VZklIdTFENnc3M2RvVTNZRHEwWldrVzBDaG1wWHNS?=
 =?utf-8?B?cTB4WDhHd0FrVjFUakpBK2hPWGxCb2ZKMjExRXlpejVqUmdNcUU0TUZraFlI?=
 =?utf-8?B?ckdOTDExS3Iwb1ZEUWl6YkZxMWJRVU1hbkR6TGRSbnFzK0t2ekhqWlBZZlhT?=
 =?utf-8?B?SFFONTBnc2R5R25HM01aVStaZGp5emliYUpqaFNZR0VpaStSUWxweExxdlFr?=
 =?utf-8?B?ODV0Tkg1VkdqRTQyUE1KQUlVdnBxaTVqWmFDV0RIZWNSK2tURjgrdndpdGhw?=
 =?utf-8?B?dDlacTMwZG5LQ0xlVEE3Rm8wQmxJWjNkUDdVZnRIaWhnR0FuWUNkTFZHRGpm?=
 =?utf-8?B?SjJlOStTNlorT25JOVI2Ymh4UXJpQkQ2Z2ZLc2oyZHpwQkZGdUw0OE1FWVlW?=
 =?utf-8?B?L0l4eitNK1g3OGUyUk95OHRWWFYya1lxak5iOXdlbEExRWxENGZEanB2ckNn?=
 =?utf-8?B?TGluem5tWGpVdWdNWHVoYnJ3dnV1clhwMVpiSjhUTlc1cjJYVGF4QzRxS0hS?=
 =?utf-8?B?SmVaamtxNnE0NEUxV3o5OHdUUmVUd2xDVVJkVkhLM0UwUnJpcFR6MXJTa2J1?=
 =?utf-8?B?ajZGSUdyRHliMW1FK3lSMVpPMG5XbDFIMlVrejg1bDU3bFA0M000WXJua2s5?=
 =?utf-8?B?VDhRd0FmNFlmYzdKNDlZb1BwVFhiMGlMKzFpcVg1U2hYVVluU3B4NmxPd1k2?=
 =?utf-8?B?ZzY4d0VXZEs1L3p1bFpCay9UaTcrM3dwbXVyM0w4dU1WakxNMEhmeFhoUHZr?=
 =?utf-8?B?V3FseTNqTjJHUTRWQVJrc1NVVGFrTlowZTRvNlphRGJOMlo0MVo0WG56TTRp?=
 =?utf-8?B?MWJhVWFpbDhQVjBXTUFVQUlmKzlLN05IczBhWUZ0Ky93b2p6TVlKSUE5S21K?=
 =?utf-8?B?SUdRaWZCVnU0ZURkUU5scUlNZlBsS2lQb2ZocUpMNXdTaUJwSDNQNHRVcDZ4?=
 =?utf-8?B?RjBBUi92ZHJ2SUJCN2M0NEgyZUo2MWdJY2g4aE4zaWdxb3B3SzRUbGwzdGtW?=
 =?utf-8?B?ekdSdTMvR1pmUGh4L2JOQ3h5aW10L0M0TjlTajk2cnVtK0lOTElzMXIrOTU3?=
 =?utf-8?B?OHo4YmNpVzgycU52MStpRElmWlNjZldMaFFmWTlUMElLZm1KOFFaZC9iQmFD?=
 =?utf-8?B?WHhBVUU4R1NSNDhvT0pGaFBFRjJPTEEyNE5uSXViNzB5THZBajNqaytIdnBS?=
 =?utf-8?B?NDdsdmFxcGltQ0JnY21SZUU0d1MvemVnTm9EOWc1RWJzVGtxTE00NXZBMEta?=
 =?utf-8?B?QlFLWW9hTGVLOHo0ZVY3M2tvYXdRcjludG9oNEMvdlhiMDdpcmNTTUNaWFB4?=
 =?utf-8?B?Nld0ODNZV3BLOFRzeldEWGFzWUN2QlFJUFpWZ3FWY3RubFIzdTJRcVB2dEh2?=
 =?utf-8?B?ZHg4akk2V1prNmhlQS9SWlNyZlJwU1dTdlRZbEdpM2d1dGdsVFVhSnJqK1po?=
 =?utf-8?B?ck11QUdVWXRXOEVIeE1lS0FTbFNnc1NVMlVnZ1h1eUoyd2VHSVFaSWpKOTJD?=
 =?utf-8?B?K3VjVjd1R0JwRTFxc3F2RndYNUxhWkE3SmVOTEZnVFd6Y1dGdytyT0djeTM4?=
 =?utf-8?Q?fe8l2REkMS54FuJrpe0acA6KG?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9eae4d-4b91-4979-8b75-08db56c66ef5
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:04:06.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnFYi0A1L4bXZXK5sNppV4Z3wSfo1fNV0Ly4OMiVzOSeK7W0EvUsLL3r5Fz1oyh6AzX+4SiETD7A8OPu61MWdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB3374
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27630.006
X-TMASE-Result: 10--12.697600-4.000000
X-TMASE-MatchedRID: hls5oAVArl//9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYLO9
	n047bamGrXMOxnDE+MTeu2H4QeCL4vRr52i2NSUsEclbAMYYY6x8m8RQoY1fdBdidqgv9+A7kCP
	MGzqmoXtKkAU17gNQngsSh9atRkcwXz51KoqDPz92GSKUJKO/tQ1bi9r2Kq3eSJHw5DazHabMoA
	Jfsjm0Topc8cdcOaXD7icOXRyDqapLuEQOcnWva0R0oIwoMPyV2AtQU7c1a/eckOuhl70pQzKF9
	ObUarRIOsgEj+Ozwd5og+vDn4uoN5cFdomgH0lngxsfzkNRlfJlVdRvgpNpe/oLR4+zsDTtFEAk
	LaTcFnoC0yE6Gxlrih1brif+VfU+hc2oHviPPihKW4Ufghq1Qw==
X-TMASE-XGENCLOUD: 2114a02d-167e-4e61-9600-00d00e4fc440-0-0-200-0
X-TM-Deliver-Signature: AC7158366A8823FFA640B280849A0996
X-TM-Addin-Auth: iAGoR9zlLyqzRLiJC/xAgi5Wcmp4Y3PuCOBruSxgx61c2LrNNYsbIcr1wp/
	bnOko4kEVM7cEtUOIalqajxErbTf3KmDuWgDkyp9UI10pIU9SUJGxHHomMLg2H1SBy34yBEH3Va
	HjgJoeR4wV/9KxcGNowmJD+tDClb0B9mxPq6ftdhkP5DYHC+vdQtgrUBNd9Kjuqr/HzkQWCA9tK
	oLGfefYpOQ+qJLdwWabdhrvWtHM4luYd9R1ZX0RDI+5ZS6A/gknfEn8vToLjJ+RQjfu0y3FJ6mK
	z4xB87T1KXnXvow=.rOjq1i44O9wDYnNh0JxxEMA40g8GzFK5UZ1Kv96DG8GSBuCjhFhKHN0NA3
	MFtg25yLYR2FSD7XqFNf54PCbRfnDlT6paBC5iPkWqpue/1oquoyrHalYlqSgAx5ArbJyhF87HE
	YopW63iCe7i19ZFkONnP2RggsNZhpbt6KlkzyI47wYH5X/2tkih4wapMaIdB1a5S+dGA2Sx7NQf
	bph5ymUr5DtFTLoKy/D/PUuiSqXoHoWZT2HlKzrjROQ1xG8oSg862TE2Grw4I4UL/9a2xLGOQIU
	D6p62fwxnGUezeLmZy06noUFZ6/Ofne6vXOWbcOXPP+ICsk2wZ/UW4d9T1Q==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 12.05.23 06:09, Alexandre Courbot wrote:
> On Thu, May 11, 2023 at 5:50=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> 3. We can have things, that V4L2 doesn't support in their stateful UAPI.
>> For example, dequeuing output buffers in decoder order.
>
> ... provided the host can do that (i.e. has a stateless decoder
> interface).

Indeed dequeuing in decoding order is obviously possible with stateless
interfaces. But it is often possible with stateful interfaces too AFAIK,
just not with V4L2. For example, we have this option on some of our
targets because the codecs are exposed using OMX with some vendor
extensions. This is a stateful interface.

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

