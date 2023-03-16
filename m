Return-Path: <virtio-dev-return-11641-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A0EC6FD19
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 10:13:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0C06AC6230
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 10:13:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D28CE986430
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 10:13:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BAA73983E51; Thu, 16 Mar 2023 10:13:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A82499863D7
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Mar 2023 10:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1678961555.538000
X-TM-MAIL-UUID: 061b686e-3904-421b-b359-b7c98cc86202
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMRYnKl1MDdC67vnhA1l7hHbC7WPEPeOgAQwhPwo52fSyUBJlKvlHii/M8mGbSNRIDNd61MefKGw0wsGgJpJtXuyP2ts8D9N7zUpGTpvM/CTcGBws4V0ku6YyEE8sZSXnCb6JYhRhUIWc8dodLqdKbZB+16G1LJ3X/Wo6FeqJZ2HsEHKr1QXInG7Woo86n6T/CPCbHlV5KjYAQNYy7xMq4mwTyeAGU2X7dn/m+gd6s98I5eywnebcSKrC7b0hRboV8ds3M4m7RedFLDQVOJ8UpXmLzCQpokEVFOMn8vWMLvPcCRsRT6m5VD+5zitujOgDiW9JJAPQVuSqqhGJVdp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTQUu+OUAvkTQZtoRgmPPbYwtR0GyrwTQC2LkqRt1q0=;
 b=JFfgpZ/+/eST1G6j9Qx8+YgH7dO4/6745ZB2Xs32k/q8K3AIs34Mvu2QqC1jG/VJGHeBDdUfjuAS1ypP5feTuDbWBAKDKSlQX+6IBYiAut2MLNTKTx8azUFxnAi+Oul3slpo/3H8Tg6m+MiH3ukXtatnrNPglLYa3R9lJU93ndf9ZTaft/Wp9Abu80YkWjJywRZXxFfAq1+swBd8z4iszzyT4eZFcEOhtkJsJNsJ/uGLAL9ArbGtNQNUmJz/yUgkcwVuUWmIu5CrBvA8lqmYpA63+nHF6lvl1Z+rDYJ4VY3q5g+z98JLUIDjb8oU1WkP2WEw1Z33kGTki0JPLe3w1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
Date: Thu, 16 Mar 2023 11:12:33 +0100
Content-Language: en-US
To: Alexandre Courbot <acourbot@chromium.org>,
 Cornelia Huck <cohuck@redhat.com>
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
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::6) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR0P281MB1466:EE_
X-MS-Office365-Filtering-Correlation-Id: fe268cf0-08cc-4536-3ac1-08db2606f60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	slbONaHP+UYPPZ/6mp90WUhIZjCSTxxAReokf4xr3nei5Xb3E2zMzcXW+mnowDeuex6weJn/kjCyQDuTY6Nrl6L3ilyG3sAdbNNJ6cYOeofsWb11uHkGUXnfv9GUkStWHzWK4mFBrWgLitzxlbUU4XAWq3yQtjWlkh4GVvLAxlRU5SoG+nSF1mHhUgie/nuaI+bGf3Nhz9aDbXNcHWLHG/Z1x/xSTdLmoXiaLda1pLi/n8gsI6ZhmSxC+qzeXpY+S0I+aX6bP4yfoY5874gYBFWi5OfetGy0eGOaGR8A6S3FHZK/wda/Dpp9DLFDkldzU7h1zFQCXhg2kcToMasZXyiw3W2FMMi042K6ckKN1rQpp2vB7+0Cyy2olIXGjQsnxt1MiZ6nw8UItL1/1mrCyG2Y31wjIcVXmmk+vCciQlQf/0oKQFJwjcAqzuDiaC4rh2gCS4OLUSVxIfv6AMFbDcVi6OGtrYFKCS6hMxUrHWlWhjyNRt0daK8sXFqpaFEOu98U/eTK+G5B4vc5yYxMuw7qdJucTVGjEKV0bZsxWxJrXPp8nfVqiJC4rdkT5sgkxJPROPk7g17QX+XuQZsg0zoXOp0T5tq2wQcBxIcXiYGYY9qM4xOQAmLTo/E9dJ+m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39840400004)(396003)(136003)(366004)(451199018)(38100700002)(31686004)(4326008)(316002)(41300700001)(83380400001)(42186006)(66476007)(54906003)(110136005)(66556008)(8676002)(66899018)(66946007)(8936002)(5660300002)(7416002)(2616005)(15974865002)(478600001)(66574015)(31696002)(86362001)(44832011)(53546011)(26005)(2906002)(36756003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEp3YWFNRXFhNjMvci9PeXdlU2wzTy9zVjd3dXJ4c3RoaXdUNk5kMGJjdEtJ?=
 =?utf-8?B?Nk1iRm1WYUYwcFhJalpZVytwT1ZQNFVJdVl6aFRQYWZGTXFGK3JQZjFuNEcx?=
 =?utf-8?B?amdmQjhtRysveDdRWFFxRXFsK3gzZ04vREJ2Z2hWQW1sVVJsNWFZWUE2UHIz?=
 =?utf-8?B?VmdycnFCVytFVWJaT0pVcjRFR2ZLM0pVdkcxNThpOTJseEVTcnJSc01HSEdJ?=
 =?utf-8?B?M2hyTUJQNU42UnJwZmR3M3JUcDhUdjFlRHgyVWRHVW45SnlGL1BOOHlKRmVs?=
 =?utf-8?B?UU5DK1FmYlA5Z3pOOFcyVU5VQkpzNGI1dzNwZmJ5NU1oQmtVUmFmRjhtcUZj?=
 =?utf-8?B?THlsaGJtWVZOQ05sTHRWYTJ5TUtXeHZPSkNtcFZyckhyajRYeEVrNW9ULzJ4?=
 =?utf-8?B?WmM1SDVtb21LR0FnWW16cE9RS1RzWEdyYkRXUkgvL1NzVVNwRGNWUTg1QXlO?=
 =?utf-8?B?R1ZwdjlHU2dNSS8vMERBN1k2RHVwazlIRzltZEZpVXo4L1M3MU5KYW5VOU1o?=
 =?utf-8?B?SEs2MHN6cVpEeWpLUmxxcENvbDczVWRqamdwbDBGY2w0TVBiSnQwUWN3MDNq?=
 =?utf-8?B?ellORDl5aElBZDgvdWFRUFFZdllwbG5ad1BXbWF6STlLR05EaWpWQ1RUMGdF?=
 =?utf-8?B?MEo5Y25BRUpOTCtRTU9QN3R1UlExN0QwU0ErVXpDNEhRWlZ4VEE3Nisvcytz?=
 =?utf-8?B?YkJoREs5cVZUZmhIQWF4aXREZ3Z0Vi9UT3JKT1RvOVdRK0JVSlRoYlVNSS9Y?=
 =?utf-8?B?MG5HZExlOFZ4dGMyRzVpaDZXZ1psYzdaYW1URENEWUZremZ6RmNsajBwQVpW?=
 =?utf-8?B?Um1hOHp0bXVFWi81VzNwTjFndXF4Q2JtaHNRd3V1VEU5S0J3RHo0RWZraEhK?=
 =?utf-8?B?RUVTUlA0dVRPZWJpSm90cWgxRVp6S000dk5HZWhZSWFwdEdmVE42eldidkJ1?=
 =?utf-8?B?cUhKaC9VQUc3VGcrZThpQk9kSnNhNXAzOTRydWJqTlFpc1UzOUp3dTc0eXNr?=
 =?utf-8?B?dHVVUnZoL01VdmM1Q0I3L0NsQlhTaURLVzYvMVVWR1N3czVxRk53Mk1VcTI2?=
 =?utf-8?B?cWRMOTlEOTBTVlFEUm1ldk1KYUh2OGUzdjRGT2IyRVQ3WTZ2ajdVNW1WVnp6?=
 =?utf-8?B?bFhPeHhDNDJhWXp1c3NPTmhOdG9RMDBOTzJWMjJUU0w3bFYwc0locStnRVlY?=
 =?utf-8?B?ZW5qT0cvZUNaUVc4T3p5U0c0NmJrR2Nlc2k0blNTcW0zMWNLS1Z1UVU1cEQ3?=
 =?utf-8?B?V1hYTXNrU2VJQVljZ2ZjRGgyR0VYOXg3WDlZZEFzdVowcENsL29FZm5sZEVK?=
 =?utf-8?B?R3lzbm1xZnpaMGJIVk0weFVXMWUwdERCYlE0d09ieGE5OEpTWkpUb1IzNkFh?=
 =?utf-8?B?blVzZFRnWE5sdDJPVTlNOU1pT3BkUlhRMmpwN3lVVHkwdmgxTmJXN25zY1BG?=
 =?utf-8?B?TkYwYlpCSHJpWWRDRTZwS3hTY1JaeVJNakQ3Nk1maGRIUHhiRW42bTBLK0Na?=
 =?utf-8?B?SU1YU2VMOWYwTHdJMzZkOStNRHRKc0VuOHJPYVlURlJCajJibUk2UzMrRnVF?=
 =?utf-8?B?Y25SQmJtaGlvWHFGR0xvZndXNVord1dEcUhyTDNwWnpEb0VORUV1TE1JR0hW?=
 =?utf-8?B?cDlYT05CNk1NVmo3aGMySnE1RWRPakR1bmpSUjJjM1kyQzZDdmpDc0poa2dV?=
 =?utf-8?B?WDFFYU9ZVE11TFVjN1Awdi9EMUJTSHgrSDB4Sk9sSmh2Sk1xWVllM1AweXR4?=
 =?utf-8?B?eXBlSWpQaWM0cmVlTGI5em5QTVQ0VHlSSDFzaHhZU1dsVElkc00yYlJkZXpa?=
 =?utf-8?B?NXZzM1BBQklnbTZ4T1I0bENTR1BaY3RhRnVqbGw2TnQ5c1VFQlZwQWVSV25s?=
 =?utf-8?B?Wnc2T290TGZTeUwwTlY2N0o4Z0xpUjgvNStwZ3hEVTMzbURtanJwQjFtWTk5?=
 =?utf-8?B?clo4TWlTSTdtRjB4MlVINmxXUDQwSzF2WTZzTHMxaHNHOFZkY2g5Vkcrc1E5?=
 =?utf-8?B?Q1ptelBQeTEra1FGU05DL08zeURjL0lSS1BKZjRPN1RTSnhlSnhVTzh0Ylc1?=
 =?utf-8?B?MFFETkJ2cmtaTFhQcmtiUnM2LzNxbEFGdFUzUFJBTEw4L1AxbzRVSWE4Y0Vi?=
 =?utf-8?Q?XU0nBo20nXyxrxdk2WlL/kEtA?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe268cf0-08cc-4536-3ac1-08db2606f60a
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 10:12:34.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csC0oFgRv1Bnb9BL3+Prw5iV+SvfeTnbLAxI8+fF11/lAu0b8yQ/3AW97NQYfbKZn+KBNS7AWyBlqzfMbIyHKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1466
X-TM-AS-ERS: 104.47.7.171-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1006-27506.006
X-TMASE-Result: 10--16.693800-4.000000
X-TMASE-MatchedRID: vEvJ7Rh1lGj/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYEe1
	VL9xxnhUjlJS3jzp1PMMzC6NxIr9NsSiwrfykIZl3nHtGkYl/VpNLPQl0QAltHROxyHvZdJsyea
	D3Xc5E51QnJiCESufLePzRjkROjtljSMRIBGXKBeyFmhU0AQsUxeK/B+WKxKsod//JilcW4BTXJ
	K7KrbSaycFWpzXYgAQbT4Iw1SEvyWzMJ0yoJG7DnAnLUK6q8ZUXV/rrWkrx2cahZ5a8XMzzMYC6
	/ZRSFPP4PkIhwvBc3rVeptTRKjYpW0roQtFmrksnVTWWiNp+v82Stbl9q+fZAnnZ4xTn7KcpLBV
	wmwORn/xI9DXb+NunHOPZ97+wFANeMPxYcSn0EPmYG5eDtyqN0pO/ORUaZ3FmyiLZetSf8mZMPC
	nTMzfOiq2rl3dzGQ1A/3R8k/14e0=
X-TMASE-XGENCLOUD: d615dffa-4e5e-4da6-b8cd-3515986270f5-0-0-200-0
X-TM-Deliver-Signature: D459492ED9A5B8A095D102FED43D75FD
X-TM-Addin-Auth: YEYcHBTVFwtAfdTGkmk+N6x/tiBFjXhesBFrrRBmbpCFAXc3mWXcHBM77dt
	DlYruNIbwL++TQoLi3FD7ds+sz7dzaBEw2b96/+LUvppZSmeWbTAFV3ilJTpTC83FSea11sL1lU
	wle/PKgIqd5cS6e/cMB25cjJIZCqBXcvCOjNCi9Uhl5+5JU+ysgdtexVkrY61vg71psD9/iDLV/
	c0Hb58rLeTiT3nvmb2rotwzojIPvvF6pcnbqDZQKib8LSsq8NjKpWW1mTQcfvW/MWYxLWGou74I
	XBhTj+bV6EdsNzQ=.vtYv3Gr1ZJc+w76HAfht1WXU/4fcaoKaTM2TG44ZY2+SZS6MBPrH5nB7hN
	uhD+bEcZmZ+Q3A/JbwLQOIooo4RdePBx9QnBnHmZNOEgwN0Wo1VFR3mdfm9/94mDJP9rQM5E4WS
	FqeMBw+rVSqyOT09feZ8Ur/JWNaA/K0AaGaOhGG7SDBWjW0Fuly2HOkAxRnM+OxxQEk0gQszVQX
	tRmfpcvF018j5SPk9Kcnv/9G5QEJcyoO0GDjOHiZij+JM92324Mh7kOQ2T6NWWvmZvafQxnNbGu
	+KHLeXvzXAYI0B0Kebsdnk9bNZmqbYpfhRSHS7sRbv3svFkeSzzzzNvxVlA==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

Hi Alexandre,

On 14.03.23 06:06, Alexandre Courbot wrote:
> The spec should indeed be considerably lighter. I'll wait for more
> feedback, but if the concept appeals to other people as well, I may
> give the spec a try soon.

Did you receive an email I sent on February 7? There was some feedback
there. It has been already established, that V4L2 UAPI pass-through is
technically possible. But I had a couple of points why it is not
desirable. Unfortunately I haven't received a reply. I also don't see
most of these points addressed in any subsequent emails from you.

I have more to say now, but I'd like to make sure that you're interested
in the discussion first.


> Meanwhile I'll also try to add support for stateful decoders and
> guest-allocated buffers to the prototype so it can be considered more
> complete.
>
> Cheers,
> Alex.
>
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

