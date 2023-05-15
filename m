Return-Path: <virtio-dev-return-12701-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABBCC77B7D
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 20:35:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5696042566
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 20:35:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC63798675E
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 20:35:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3A02198651C; Mon, 15 May 2023 20:35:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5411F986511
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 May 2023 20:34:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684182845; x=1686774845;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTwbkSnAutP0/s8Th/OIgXgwsk0t6sn2vjCwpk4liEU=;
        b=fX2rMK2UiVuMQx6UDtevI3YDrX0WU0FKNjD3jnA93dG2mUbzaJ9z3lDg7EZz2w5mwf
         vKbx6sEAD4YH9bNiJS0NuxQp8266iHPfigzpq8mRTsYRcl/GhhktK3brtBVJDsDBgH8X
         FY9lcdwLx6yPnAgT8zEoD902lueOEEwykugbRTyJMG4/FkGLtQvT59Ym0gTsD+zc2gsz
         UVGajIB+xEd5xNXraTKZx8FV5nTKKXoux0UBtjnBmbjBswCAl7iX27EYByBzdR0COVOh
         VGB3u1sw8CrQLd7LF4dkrJovN58olU5+jcOZX5NL4Q6d8EX+f9QDYWNtILDT3VMzyHQF
         KGtg==
X-Gm-Message-State: AC+VfDy76sJj6hzVeaOPIaPDE63tJbj5CZdq9Q0O/+99977jkV6Ng+/Y
	b+dAzpkEx+3poN76o7tzDWAcZLymGpFlv+Dy0nRdmCLnNDwocf2gktbZrQ==
X-Google-Smtp-Source: ACHHUZ69lzDf533EgUhGHfPL+wjbXaojqvWyMI9mmV7NhMObvepFA9nsz5GRU+pq25mjTRI16IApgiok7kgYKPNNWe0=
X-Received: by 2002:a7b:c3cf:0:b0:3f4:21cf:b4a4 with SMTP id
 t15-20020a7bc3cf000000b003f421cfb4a4mr19618692wmj.20.1684182844983; Mon, 15
 May 2023 13:34:04 -0700 (PDT)
MIME-Version: 1.0
From: "T.J. Alumbaugh" <talumbau@google.com>
Date: Mon, 15 May 2023 14:33:29 -0600
Message-ID: <CABmGT5Hv6Jd_F9EoQqVMDo4w5=7wJYmS4wwYDqXK3wov44Tf=w@mail.gmail.com>
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] [RFC PATCH 0/1] virtio-balloon: Add Working Set Reporting feature

This is a proposed spec expansion for a Working Set Reporting feature
in the balloon with driver patch here:

https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@google.com/

with device implementation here:

https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02503.html

It describes the requirements for a VIRTIO_F_WS_REPORTING feature bit
on the balloon device.

Motivation
==========
When we have a system with overcommitted memory and 1 or more VMs, we
seek to get both timely and accurate information on overall memory
utilization in order to drive appropriate reclaim activities. For
example, in some client device use cases a VM might need a significant
fraction of the overall memory for a period of time, but then enter a
quiet period that results in a large number of cold pages in the guest.

The balloon device has a number of features to assist in sharing memory
resources amongst the guests and host (e.g free page hinting, stats, free page
reporting). As mentioned in slide 12 in [1], the balloon doesn't have a good
mechanism to drive the reclaim of guest cache. Our use case includes both
typical page cache as well as "application caches" with memory that should be
discarded in times of system-wide memory pressure.

Working Set Reporting
=====================

Working Set reporting in the balloon provides:

 - an accurate picture of current memory utilization in the guest
 - event driven reporting (with configurable rate limiting) to deliver reports
   during times of memory pressure.

The reporting mechanism can be combined with a domain-specific balloon policy
to drive the separate reclaim activities in a coordinated fashion.

TODOs:
======

 - There are some small differences between this spec and the
   implementation in the data exchange protocol in the device. We wanted to
   get feedback on this diff at an early stage though, rather than get every
   piece nailed down with precision.

References:

[1] https://kvmforum2020.sched.com/event/eE4U/virtio-balloonpmemmem-managing-guest-memory-david-hildenbrand-michael-s-tsirkin-red-hat

T.J. Alumbaugh (1):
  virtio-balloon: Add Working Set Reporting feature

 device-types/balloon/description.tex | 228 ++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 1 deletion(-)

-- 
2.40.1.606.ga4b1b128d6-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

