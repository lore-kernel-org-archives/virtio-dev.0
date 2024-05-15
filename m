Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB502744C
	for <virtio-dev@lists.linux.dev>; Wed, 15 May 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765742; cv=none; b=K2+NX8ylm+ZfrJnoklRl17RzDMsVmOAdcM/EeEZl9J8Tvhh1jp5q+JSSPg1CAfsjxxKJD0t0NAklkQ+8010gzKshi52R66HkMXPt3AaBSqJcUZ2ZwSpnxTvS9x6M+bDBW3mVGuPYpXnroXO6et2T4Wxj+qNV8D0vIzfbXC7x2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765742; c=relaxed/simple;
	bh=4kQZBwBgDi6moFX/6rMB0pA9fFcDgrOHlLQO21fXaSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u6j/8nSlwIIIHm4JVAvTqsXLQpPr6vI3EBzeJzrObZDnSRgj6pgaFdxsM0FYzJUSV1TN5vFgjpJ2R+1pUw3L3dl0nZE7OXpGJaKT9JtxYtBPbgge3RulY98j1t7wQeOiUsC6/ff5W2Ulbp/OKCIQ6yJskgU6sulEmqCF/0Xcwc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLarA1tl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLarA1tl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715765739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=de9IgUGUYzzjeyLy+btO2z3Bvwzs5WaKonqi6NgYEpE=;
	b=TLarA1tltxQHniQBuN7mi5FH5bhvxqS5xEJDlf01XTz1EAs7Loo/866Mxnwa1BGIbKRdeo
	9JeGFAZWncU8gMlUcN7LnNICbUEn+LMCn1zHe7BWDOdNygAIlcqZ/1vvDTFRhH59q4OUZw
	yZqKFrdDyuXTPI5PvVLsSMLwnsWKK0M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-z5zqUmwNPFaP2jN6VP-ZfQ-1; Wed, 15 May 2024 05:35:38 -0400
X-MC-Unique: z5zqUmwNPFaP2jN6VP-ZfQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a599b55056bso401537466b.0
        for <virtio-dev@lists.linux.dev>; Wed, 15 May 2024 02:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715765736; x=1716370536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de9IgUGUYzzjeyLy+btO2z3Bvwzs5WaKonqi6NgYEpE=;
        b=up0QKoSFX3C9EmeeE4SbRwieRRntmbPmNGW3VB5HPFlBO0uM+C5iBGZbKCie8A00Wj
         uL2XTrow1SU28CZR8rrReoj+eiCWxM2tExdiKT8pC8OulOry9ER1GRIhYXtuC7FUDhse
         GXgKQtEp8qmFzK6GQd+MAj+nBHF5znZUK0hgYv+NpOqgVJgDG6U8oAEbpP5EsdwwOi4N
         a3v8fMCXQt7E23OhATYVbdl32RUP13S+Bc1MULqiD5b8vFaoUEs2UGS/LYaM9b5iPCfb
         GIWhDohahQJDSGEohZoUQqzgo9IM2Va3XYkk8kGYoT+P9UA811B85m5jKqnaHTCnHrzw
         gggw==
X-Forwarded-Encrypted: i=1; AJvYcCUasphrxULjcSuf9MquBHUGWut1k1PsztAcs7dIVu0GpyNefuJpEpUA/mSRCnQJNeUgjtHicInMzwPO22I8UAUWicXutv0A1SqLqQ==
X-Gm-Message-State: AOJu0YwW8u3Y2KfnJ2TFhrZDYk6kZc8m2Scpmw4Hz02x5+O0nyFltiH5
	sFAfDixFCP/YmnlleQlGaSIik0ZrIH7Sl6xV5blmWtsCyk2We91hHiut5QxlfeglS0HB6SedEXQ
	IltUzt+PdJLWG2lslFJIHgvlo5UQeno8LYp0JZDCkXr5Qz/VVvwjKczZRdkPT40s8JfI=
X-Received: by 2002:a17:906:f296:b0:a59:c833:d272 with SMTP id a640c23a62f3a-a5a2d5356eamr1100735166b.13.1715765736502;
        Wed, 15 May 2024 02:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeUre0tRYOXpDwsNUuqQ/unH1G5iufuvB3grj33f/KAyCP61Q8xHJJQa3XVhPCCoD7GGWbAA==
X-Received: by 2002:a17:906:f296:b0:a59:c833:d272 with SMTP id a640c23a62f3a-a5a2d5356eamr1100733766b.13.1715765736057;
        Wed, 15 May 2024 02:35:36 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-77.business.telecomitalia.it. [87.12.25.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17922159sm837677166b.97.2024.05.15.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 02:35:35 -0700 (PDT)
Date: Wed, 15 May 2024 11:35:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.linux.dev, virtio-dev@lists.linux.dev, 
	OASIS-virtio@connectedcommunity.org
Subject: Re: [PATCH] README.md: update mailing list info
Message-ID: <jxqigp3mezfyuma73uslqtp62onz3myg4i6tsopj577emb5urs@i5d34hxtankr>
References: <a7999f18e2112605b167c623f9fe1ab67c535569.1715764807.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a7999f18e2112605b167c623f9fe1ab67c535569.1715764807.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 15, 2024 at 05:20:33AM GMT, Michael S. Tsirkin wrote:
>As approved by the TC, we are moving to a less formal
>way of discussing the specification, on the mailing lists
>provided by the Linux Foundation:
>
>https://groups.oasis-open.org/higherlogic/ws/public/ballot?id=3820
>
>Update README.md accordingly.
>
>Use this opportunity to explain when and how to use each
>mailing list.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> README.md | 80 +++++++++++++++++++++++++++++++++++++++++++++++--------

I see some references to the mailing lists in CONTRIBUTING.md and
newdevice.tex, should we update also them?

Thanks,
Stefano

> 1 file changed, 69 insertions(+), 11 deletions(-)
>
>diff --git a/README.md b/README.md
>index 2bdf485..c06caf6 100644
>--- a/README.md
>+++ b/README.md
>@@ -76,11 +76,12 @@ font packages.
> <dd>
> </dl>
> <h4>Providing Feedback</h4>
>-Feedback must be provided the <strong>virtio-comment</strong> mailing list,
>-and archived in the mailing list archives.
>-<p>See <A
>-HREF="https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback">
>-https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback</A>
>+Informal feedback is accepted through the <strong>virtio-comment</strong> mailing list,
>+and is archived in <A HREF="https://lore.kernel.org/virtio-comment/">the mailing list archives</A>.
>+To provide feedback, subscribe by sending mail to
>+<HREF="mailto:virtio-comment+subscribe@lists.linux.dev">virtio-comment+subscribe@lists.linux.dev</A>,
>+then after confirming you agree to the IPR sending your feedback to
>+<HREF="mailto:virtio-comment@lists.linux.dev">virtio-comment@lists.linux.dev</A>.
> <p>Note that only plain text part of the message is archived, and all
> attachments are stripped. Accordingly, messages sent to the
> mailing list should use text/plain encoding and not
>@@ -106,8 +107,38 @@ Signed-off-by: Name &lt;email&gt;<br>
> git format-patch -o proposal1/ HEAD~1..<br>
> ... generates a new directory proposal1/ and a file starting with 0001- ...<br>
> <p>
>-git send-email --to=virtio-comment@lists.oasis-open.org proposal1/0001-*
>+git send-email --to=virtio-comment@lists.linux.dev proposal1/0001-*
> </code>
>+
>+<dl>
>+<dt>When to use the virtio-comment mailing list:</dt>
>+<dd>
>+  questions and change proposals for the Virtio specification,
>+  including the specification of basic functionality, transports and
>+  devices.
>+</dd>
>+
>+<dt>When <em>not</em> to use the virtio-comment mailing list:</dt>
>+<dd>
>+  questions and change proposals for Virtio drivers and devices
>+  implementing the specification.
>+  (please use the <A HREF="mailto:virtio-dev@lists.linux.dev"> virtio-dev mailing list</A> for this).
>+</dd>
>+
>+<dt>To do:</dt>
>+<dd>
>+ send email preferably in text format (best for archiving).
>+</dd>
>+
>+<dt>Not to do:</dt>
>+<dd>
>+<ul>
>+<li> copy both virtio-dev and virtio-comment mailing lists (instead, pick one);
>+<li> send full copies of the virtio spec (in any format).
>+</ul>
>+</dd>
>+
>+</dl>
> <h4>Note for TC Members</h4>
> <p>TC Members should review TC specific
> process rules under "Further Description of this Repository"
>@@ -116,16 +147,43 @@ HREF="https://github.com/oasis-tcs/virtio-admin">https://github.com/oasis-tcs/vi
>
> </div>
> <h4>Implementation discussion</h4>
>-Implementation discussion should take place on the <strong>virtio-dev</strong> mailing list,
>-and be archived in the mailing list archives.
>-<p>See <A
>-HREF="https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback">
>-https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback</A>
>+Implementation discussion takes place on the <strong>virtio-dev</strong> mailing list,
>+and is archived in <A HREF="https://lore.kernel.org/virtio-dev/">the mailing list archives</A>.
>+To participate in the discussion, subscribe by sending mail to
>+<HREF="mailto:virtio-dev+subscribe@lists.linux.dev">
>+virtio-dev+subscribe@lists.linux.dev</A>.
>+After agreeing to the IPR, to participate in the discussion, send
>+mail to <HREF="mailto:virtio-dev@lists.linux.dev">virtio-dev@lists.linux.dev</A>.
> <p>This is the correct list to copy on Linux virtio UAPI change proposals.
> <p>Note that only the plain text part of the message is archived, and all
> attachments are stripped. Accordingly, messages sent to the
> mailing list should use text/plain encoding and not
> have any attachments.
>+
>+<dl>
>+<dt>When to use the virtio-dev mailing list:</dt>
>+<dd>
>+  questions and change proposals for Virtio drivers and devices
>+  implementing the specification.
>+</dd>
>+
>+<dt>When <em>not</em> to use the virtio-dev mailing list:</dt>
>+<dd>
>+  questions and change proposals for the Virtio specification,
>+  including the specification of basic functionality, transports and
>+  devices (please use the <A HREF="mailto:virtio-comment@lists.linux.dev"> virtio-comment mailing list</A> for this).
>+</dd>
>+<dt>To do:</dt>
>+<dd>
>+ send email preferably in text format (best for archiving).
>+</dd>
>+
>+<dt>Not to do:</dt>
>+<dd>
>+copy both virtio-dev and virtio-comment mailing lists (instead, pick one).
>+</dd>
>+</dl>
>+
> <h4>Use of github issues</h4>
> Note: according to the virtio TC rules, all official TC communication
> is taking place on one of the TC mailing lists.
>-- 
>MST
>
>

