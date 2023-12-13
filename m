Return-Path: <virtio-dev-return-14143-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E7DC4167D
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Dec 2023 06:33:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 753F5429A8
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Dec 2023 06:33:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 567339866B0
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Dec 2023 06:33:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2EFED98669B; Wed, 13 Dec 2023 06:33:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A8B398669C
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Dec 2023 06:33:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702449218; x=1703054018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9p8/aS0DcOZN8+84ZMld49VFTAkEWGnyTWKIx1cHbc=;
        b=Nq/dvx2bYhFO8Y4l6lLJVc5hB/JdkdTgmIdjKRtG4nr4ey0k1f49tEfdyL4T8hydYd
         YnFysjlsvMMtDL1FulG0cyJqr5eIw+vZQjFTnUYO3m7L0Sa555wSHsu049f1aC9Kj6XS
         yO7WSiw/nqLe0p/qdYo0MZftIgCbRP2h7v67OTVdlbWvjyqN7QtgL5LAyiRgiaKSprC2
         +CeEonwVSrZJ0A7Zui3hCGdqbSRVW8X7LdTrkbZCn/qGYjJ24UXw68UZ55XvTWai8LoJ
         ZWrDY7aX9DnWpcTKN3RdrwQmTwZoaKsGGUEqVXzPEE2hFvLLyP+fQiu/e3AaUwkWeoGF
         Q67Q==
X-Gm-Message-State: AOJu0Yyld/pNWi//y01gtBOHALWla10OXK/P1feNlsUSgA0oGqRHSAAs
	/WqTYy/FChTpezlmhZk44Zs6ug==
X-Google-Smtp-Source: AGHT+IFczjvcizzn2ujL+SLGH7PssuoA4yNSPN+Tsz72PXu63XHsPUs7UAvlcsskYUd2hV4r0ktChA==
X-Received: by 2002:a17:903:1206:b0:1d0:9a6b:52ab with SMTP id l6-20020a170903120600b001d09a6b52abmr4442562plh.45.1702449217991;
        Tue, 12 Dec 2023 22:33:37 -0800 (PST)
Date: Wed, 13 Dec 2023 12:03:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com,
	quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Message-ID: <20231213063335.xaejh3565gkn5cvh@vireshk-i7>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-3-Harald.Mommer@opensynergy.com>
 <20231212103411.wbjmr5mefmxfnsib@vireshk-i7>
 <87f06ede-ac54-48cd-8135-ea2c8f5548f3@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f06ede-ac54-48cd-8135-ea2c8f5548f3@opensynergy.com>
Subject: Re: [virtio-dev] [RFC PATCH v1 2/3] virtio-spi: Add virtio-spi.h (V4
 draft specification).

On 12-12-23, 19:58, Harald Mommer wrote:
> On 12.12.23 11:34, Viresh Kumar wrote:
> I'm working on V8. It's coming to an end, will still have to check some
> details but it's close. Internal review pending. Now there is a V9 and I
> will also have to look at this. Maybe I will send V8 and subsequently update
> to V9,

I hope you are talking about V8/V9 of the spec here, as I only see one
version of the Linux driver on the list. Please keep me in cc if
possible.

> > On 27-10-23, 18:10, Harald Mommer wrote:
> > > +++ b/include/uapi/linux/virtio_spi.h
> > > @@ -0,0 +1,130 @@
> > > +/* SPDX-License-Identifier: BSD-3-Clause */
> > Maybe this should be:
> > 
> > SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > 
> > ?
> Looking into what others do here. virtio_blk.h, virtio_input.h and
> virtio_iommu.h for example: None is using GPL-2.0 here. virtio_iommu.h is
> using exactly the same header as we do.

Looked at all headers for SPDX License in include/uapi/ and this is
what I see (Yes there are many non SPDX licenses there):

    522 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
    106 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
     18 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
     16 /* SPDX-License-Identifier: LGPL-2.1+ WITH Linux-syscall-note */
     16 /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
     11 /* SPDX-License-Identifier: GPL-1.0+ WITH Linux-syscall-note */
      6 /* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
      5 /* SPDX-License-Identifier: BSD-3-Clause */
      4 /* SPDX-License-Identifier: LGPL-2.1 WITH Linux-syscall-note */
      4 /* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
      4 /* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
      3 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
      2 /* SPDX-License-Identifier: MIT */
      2 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
      2 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR CDDL-1.0) */
      2 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
      2 /* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
      1 /* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR MIT) */
      1 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause */
      1 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
      1 /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note*/

Also Documentation/process/license-rules.rst says:

"The license described in the COPYING file applies to the kernel source
as a whole, though individual source files can have a different license
which is required to be compatible with the GPL-2.0::

...

Aside from that, individual files can be provided under a dual license,
e.g. one of the compatible GPL variants and alternatively under a
permissive license like BSD, MIT etc."

And so I thought we may want this to be a dual license.

> > > +/* All config fields are read-only for the Virtio SPI driver */
> > > +struct virtio_spi_config {
> > Can you please add proper doc style comments for the structures ?
> Checking my current code. This is updated in the V8 version.

V8 of this patch ?

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

