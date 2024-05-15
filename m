Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC8433DC
	for <virtio-dev@lists.linux.dev>; Wed, 15 May 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764857; cv=none; b=WAoRQcXcORf7prXOfvtWDsXLx9q3GWrVTdchxfbyPpO7AScGfevZ28pJCoMHE+83Eokf/tgxsSCw5MkOzBE1VYEGQ+wq+b54Aj1BA9NJYDf32JJlMtUgO+IcDddJnMDtVJcGvyHM0M5VNkE/R9OxEzfviN6tb1VuQaIiPIoBwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764857; c=relaxed/simple;
	bh=uabB7uqUe9IXjQZ4eK6b6mpQuI7IrV6ptziI0mDtiSY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iYb14zF4eaSWkSBBQwIH9xOw5GvOCECMi+QMO48OTT3GbQ0xH7IrQbHl0aPYYg6qPjg2b7+Pxj86K3zZpSRjJye9+Ha4jTkAtERE7lfXVvTvazwtBA2v+FwL/a4iqlwphzzS7IFxHbA7p1u4QaW59UpCgqqDM03w+yWLGs9ebHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFMyDu4G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFMyDu4G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715764854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=iTXsZTYVVjRo8+6Pt7h3HVqXiHlT1xQWRIGRXKe+28s=;
	b=OFMyDu4GBMS4+olBmIDYw8IWSCO+PLjn0fLeDnqei4Gf3m6m6kuwM8tqYTM4f/WDTvJ20A
	lifnn52Sj8RfY6lkE3wiEArQva/6nsnZy1ueabw9abqmPohHUyKJl0LG01NyU3BpWKIv0j
	AWz2QksWu3HcPwGPgeBD904dmGUbcUA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-xRQiu2amOnSHUR9cL5FiBw-1; Wed, 15 May 2024 05:20:38 -0400
X-MC-Unique: xRQiu2amOnSHUR9cL5FiBw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34dd570f48cso3656937f8f.3
        for <virtio-dev@lists.linux.dev>; Wed, 15 May 2024 02:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715764836; x=1716369636;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTXsZTYVVjRo8+6Pt7h3HVqXiHlT1xQWRIGRXKe+28s=;
        b=KpiPPOthVSnkbUKifU37ksQNLxIssHDcjFLxkO4w5PLWw8/6+MRKqzIHngGJhA46/1
         dOuyRjgk+7CIzikTBIllGk0V7oNbZssqJaxPUexsMcSd11tWtSJGPPQobk8wAKe8moUl
         gpetUeoCjYcSrllerIFMuqQGFG9d9h+/OLda4yXTKn6fXjLEeTXR73t9cuTZ4EOv7bu3
         wi9HMCyF2y80utEzNdaM3vY8m+N2xqkZ7DE23ZXB+MvbZWXbyjhxgJI8N0uJFTkRQBN2
         uwgMDTGV8sFhbzMGO4GEeP+ApcJg1ZJMQ00Ru49FUj4OxTqEGsaQYahLr91yy7gyCuPP
         DYmA==
X-Forwarded-Encrypted: i=1; AJvYcCWOVHcXHIQgZNuC+qCwswgvJqz+Ybl2N1K6NBCUbMEqcTRJBv5Jn4A6ZDJEnkLoWCbkY94IYkbi1YzwOJKel0nzmSqVMykeeCtWPw==
X-Gm-Message-State: AOJu0Yx+99LzO/c0K4LFF/2c5bAOwaxIBCCacqcWBZguYQbZlZ1NDRKy
	602ZzBpwjMyhAkFNvI6WsgOgBvIwi86gK1echWyiCVu0+LY9ewZ36O2nNzU/4wGPPNDKyJ8Sf8P
	RyonYLOR6xyqPi3J1q1n2bfj4/YeQuQrIiyqA6RjAg8fegt055eqAWA3ICDnVH35gW00=
X-Received: by 2002:a05:6000:1370:b0:34c:a95f:1114 with SMTP id ffacd0b85a97d-3504a7375ccmr8604999f8f.40.1715764836574;
        Wed, 15 May 2024 02:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3up2P0hHaTklD9gYmhk6xsllM9NPFPHX4graXN/12bVruf946hIdGyx5w4qTtIgCPxjVNNg==
X-Received: by 2002:a05:6000:1370:b0:34c:a95f:1114 with SMTP id ffacd0b85a97d-3504a7375ccmr8604981f8f.40.1715764835894;
        Wed, 15 May 2024 02:20:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc99sm15849089f8f.11.2024.05.15.02.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 02:20:35 -0700 (PDT)
Date: Wed, 15 May 2024 05:20:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.linux.dev, virtio-dev@lists.linux.dev
Cc: OASIS-virtio@connectedcommunity.org
Subject: [PATCH] README.md: update mailing list info
Message-ID: <a7999f18e2112605b167c623f9fe1ab67c535569.1715764807.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As approved by the TC, we are moving to a less formal
way of discussing the specification, on the mailing lists
provided by the Linux Foundation:

https://groups.oasis-open.org/higherlogic/ws/public/ballot?id=3820

Update README.md accordingly.

Use this opportunity to explain when and how to use each
mailing list.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 README.md | 80 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 11 deletions(-)

diff --git a/README.md b/README.md
index 2bdf485..c06caf6 100644
--- a/README.md
+++ b/README.md
@@ -76,11 +76,12 @@ font packages.
 <dd>
 </dl>
 <h4>Providing Feedback</h4>
-Feedback must be provided the <strong>virtio-comment</strong> mailing list,
-and archived in the mailing list archives.
-<p>See <A
-HREF="https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback">
-https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback</A>
+Informal feedback is accepted through the <strong>virtio-comment</strong> mailing list,
+and is archived in <A HREF="https://lore.kernel.org/virtio-comment/">the mailing list archives</A>.
+To provide feedback, subscribe by sending mail to
+<HREF="mailto:virtio-comment+subscribe@lists.linux.dev">virtio-comment+subscribe@lists.linux.dev</A>,
+then after confirming you agree to the IPR sending your feedback to
+<HREF="mailto:virtio-comment@lists.linux.dev">virtio-comment@lists.linux.dev</A>.
 <p>Note that only plain text part of the message is archived, and all
 attachments are stripped. Accordingly, messages sent to the
 mailing list should use text/plain encoding and not
@@ -106,8 +107,38 @@ Signed-off-by: Name &lt;email&gt;<br>
 git format-patch -o proposal1/ HEAD~1..<br>
 ... generates a new directory proposal1/ and a file starting with 0001- ...<br>
 <p>
-git send-email --to=virtio-comment@lists.oasis-open.org proposal1/0001-*
+git send-email --to=virtio-comment@lists.linux.dev proposal1/0001-*
 </code>
+
+<dl>
+<dt>When to use the virtio-comment mailing list:</dt>
+<dd>
+  questions and change proposals for the Virtio specification,
+  including the specification of basic functionality, transports and
+  devices.
+</dd>
+
+<dt>When <em>not</em> to use the virtio-comment mailing list:</dt>
+<dd>
+  questions and change proposals for Virtio drivers and devices
+  implementing the specification.
+  (please use the <A HREF="mailto:virtio-dev@lists.linux.dev"> virtio-dev mailing list</A> for this).
+</dd>
+
+<dt>To do:</dt>
+<dd>
+ send email preferably in text format (best for archiving).
+</dd>
+
+<dt>Not to do:</dt>
+<dd>
+<ul>
+<li> copy both virtio-dev and virtio-comment mailing lists (instead, pick one);
+<li> send full copies of the virtio spec (in any format).
+</ul>
+</dd>
+
+</dl>
 <h4>Note for TC Members</h4>
 <p>TC Members should review TC specific
 process rules under "Further Description of this Repository"
@@ -116,16 +147,43 @@ HREF="https://github.com/oasis-tcs/virtio-admin">https://github.com/oasis-tcs/vi
 
 </div>
 <h4>Implementation discussion</h4>
-Implementation discussion should take place on the <strong>virtio-dev</strong> mailing list,
-and be archived in the mailing list archives.
-<p>See <A
-HREF="https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback">
-https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback</A>
+Implementation discussion takes place on the <strong>virtio-dev</strong> mailing list,
+and is archived in <A HREF="https://lore.kernel.org/virtio-dev/">the mailing list archives</A>.
+To participate in the discussion, subscribe by sending mail to
+<HREF="mailto:virtio-dev+subscribe@lists.linux.dev">
+virtio-dev+subscribe@lists.linux.dev</A>.
+After agreeing to the IPR, to participate in the discussion, send
+mail to <HREF="mailto:virtio-dev@lists.linux.dev">virtio-dev@lists.linux.dev</A>.
 <p>This is the correct list to copy on Linux virtio UAPI change proposals.
 <p>Note that only the plain text part of the message is archived, and all
 attachments are stripped. Accordingly, messages sent to the
 mailing list should use text/plain encoding and not
 have any attachments.
+
+<dl>
+<dt>When to use the virtio-dev mailing list:</dt>
+<dd>
+  questions and change proposals for Virtio drivers and devices
+  implementing the specification.
+</dd>
+
+<dt>When <em>not</em> to use the virtio-dev mailing list:</dt>
+<dd>
+  questions and change proposals for the Virtio specification,
+  including the specification of basic functionality, transports and
+  devices (please use the <A HREF="mailto:virtio-comment@lists.linux.dev"> virtio-comment mailing list</A> for this).
+</dd>
+<dt>To do:</dt>
+<dd>
+ send email preferably in text format (best for archiving).
+</dd>
+
+<dt>Not to do:</dt>
+<dd>
+copy both virtio-dev and virtio-comment mailing lists (instead, pick one).
+</dd>
+</dl>
+
 <h4>Use of github issues</h4>
 Note: according to the virtio TC rules, all official TC communication
 is taking place on one of the TC mailing lists.
-- 
MST

