Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0C3D966
	for <virtio-dev@lists.linux.dev>; Wed, 15 May 2024 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760017; cv=pass; b=NTIF7c4ErE+fQ+IDZy4sqMgTbbf8XcPZLuCp47zWOQdTIujQfhuMfQpOAId2DHnayOK4E3vL6EyUI6dQ3+8BOF4YxGnEYFvoF9SKcXJ+hC/4Su/hR9kjuK3mX7OcOzgQ0r/u6CBNhXaOLtR8I2I9HjV0M0l6fGv+yT30xy9Kp6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760017; c=relaxed/simple;
	bh=Q3Mt4x6UwMw159lStifoWq9iTkEO1d061MDuLsxqTo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/p14y8Rshl40SqkAgN3SOBmjhsA8eQxCBNGa5FxoI8LYRfaTcQuF1pq0p4ZfWBvOSOfOkiJHUydPdmBpq6k9rff49e5gAyKgav9u+iSlToiwnaETBSFrei2BOVWchm0sGLl2Cj+VdIszsOccliDCLwvGzjqzZuREyVUzB7KnWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=redhat.com; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34de61b7ca4so4545352f8f.2
        for <virtio-dev@lists.linux.dev>; Wed, 15 May 2024 01:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715760013; x=1716364813;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:references:in-reply-to:message-id
         :date:subject:cc:to:from:delivered-to:delivered-to:resent-to
         :resent-message-id:resent-date:resent-from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cRxg9MkOYWKBf3Ixh2HHbi38NEnN7AqilBnEWCQK8T8=;
        b=jTGt7j4IEd5/mI2/560OKQWlH9mdLotvhkQKNGk0PMMUZL7V83JG8vomixeAQbRvOY
         74pq4/SsN0wMsnpxwwbKntdQUXrIWV+4lMzIivFKTtTSM3wg9bmZ5f6KAkEOwpvLR7O4
         TN93IF31giWUZXqNdubElOmyuVJWyqYf3snFHcjKSg1ffrqD+9JETdpIkkRysr4qvgw6
         Pq8cGJXcZcPOfUUpguIbsuOrFnkYSAbL/BXyggG4Q97CaVITUGNd6yAI02HcwPHTHwqL
         7ic0EeG3EQJRQt5kqw+Mh+CFD51N3ql0XbdBsXvyiWcASl16VbOI6SkGEtqPGf2k8vjp
         p5cg==
X-Forwarded-Encrypted: i=2; AJvYcCUMsi8Nf3K8S40/QMw5uc2mq4ZY9sswb66SNdedVcSjenpdVu2eKAcSfTa2Il+nW0w7nV0vkKFpnqHJcYFOUOjY/ziVkOnsLEqU/w==
X-Gm-Message-State: AOJu0YzVBFxbcJNA63Y0BX94b/fkuskGYoYjg1h/efwn634LvvWXWJ+C
	nYPSbHf8qirx/Cei6wBIm9PudQX9aQUhgX8IFWatoDQciHDaiQFqUxX4BBaNBlYQJNv9GKIPbJU
	mgJUjb/2sfknEPKBbvuVuJ1Qa2QZqLsqzrD5ljh++OTxqC9HG1zg75KdODZGivlPXBhblM4KoWc
	7P2u1taxxSSrH9GFpWpOvUmcY7zxMmsKiQkAU=
X-Google-Smtp-Source: AGHT+IGNLuI0DG3GASMEjpFob8W1BJ1sTrkXCJ5EMWIdgt3zBur8LyhFqjyLcRxXNQnZ19BCIhGZNw==
X-Received: by 2002:adf:fd43:0:b0:343:7fa5:3462 with SMTP id ffacd0b85a97d-3504a63121amr13021994f8f.24.1715760013295;
        Wed, 15 May 2024 01:00:13 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc082sm15762562f8f.107.2024.05.15.01.00.12
        for <virtio-dev@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:00:12 -0700 (PDT)
Resent-From: "Michael S. Tsirkin" <mst@redhat.com>
Resent-Date: Wed, 15 May 2024 04:00:09 -0400
Resent-Message-ID: <ZkRriagvk-ZitQI0@redhat.com>
Resent-To: virtio-dev@lists.linux.dev
Received: from imap.gmail.com [74.125.133.109]
	by tuck.redhat.com with IMAP (fetchmail-6.4.38 polling redhat account mtsirkin@redhat.com folder INBOX)
	for <mst@localhost> (single-drop); Mon, 13 May 2024 09:33:35 -0400 (EDT)
Received: by 2002:a05:7022:c8d:b0:7a:7b9f:ea34 with SMTP id ek13csp2070739dlb;
 Mon, 13 May 2024 05:21:24 -0700 (PDT)
X-Forwarded-Encrypted: i=2;
 AJvYcCWAHgZUK9jj6Z4tll06NQntqwE46EuedE7D9dhJ8892+xT7IPiR1yPK/Pb4hv4wBQeacQV6XtcrvLwJPmlGVLMwFCvRdSt0nV8s
X-Received: by 2002:ac8:5994:0:b0:43a:db0c:ed9e with SMTP id
 d75a77b69052e-43dfdcd71efmr129306061cf.43.1715602884238; Mon, 13 May 2024
 05:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1715602884; cv=none; d=google.com;
 s=arc-20160816;
 b=fK4dCmepAHzcHOelV2hdhSuE6473yYVggkcZ/T7tJVhydmx++sqeCbrm8t1+g/rnxu
 WqOI+CJN5veAPSaDA+zTsUkxc53mPVvHxFTPH84dw1DtYo4GMIZFx/vEPB0epbUPOfu/
 3DTf3Ff4bvwWti+JYdnhv5iBvYJyzVTifIwWISs2gplneRmio6pYE2S7tz9vaDKZ+e5T
 1HmFsxA3k2QkJs9OHDJDwRjaIoyNEtaZwBjQ4HPfFWCdm6IYR6+sfqM0V0wlVmwX36nG
 c6QPznAIINeX8Cp5P5/JfT7rFFXowr5spE0V8XUvX8snOTtrKT5h7qo605cBukN1GNSY 32qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20160816; h=content-transfer-encoding:mime-version:list-unsubscribe
 :list-subscribe:list-id:precedence:references:in-reply-to:message-id
 :date:subject:cc:to:from:delivered-to;
 bh=cRxg9MkOYWKBf3Ixh2HHbi38NEnN7AqilBnEWCQK8T8=;
 fh=eYfS26p4bk+FZQPL8VhilQgKGw/bxvwbGho54BggsgE=;
 b=QzdxyMcKOHFtRlZSZkklDVGdnaWTOM5Ucfwcj1zciMhBMHG8eHl/cIV1JL5uuaZsmm
 yumHNKNNfdNszdkHSls8eXPX5oM7yfQ3UIq1VNter+wa98EzrjbMjNWHut0wORpHG6WM
 Sj5Q0nC2+LejzSKJX6vu7Na5MnHpBoDG2do1VPObwynII9Z3LUMB3uMESdXj55Lv7MoJ
 lzV5M+jJuzdUO5vIkHEh8DhDsca1pLInpt093azgQ497zhEui3rTVpMG36uKa83lvY/F
 vzY1T+0Q8/R2KH59f8qISUfIVgE82w4YgrYfJ1eC+oG4AYzNoiLUT2gZOfGmLjemE0+E 4jNQ==;
 dara=google.com
ARC-Authentication-Results: i=1; mx.google.com; spf=pass (google.com: domain
 of virtio-comment+bounces-4-mst=redhat.com@lists.linux.dev designates
 147.75.48.161 as permitted sender)
 smtp.mailfrom="virtio-comment+bounces-4-mst=redhat.com@lists.linux.dev"
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com. [170.10.128.131]) by mx.google.com with
 ESMTPS id d75a77b69052e-43df56d162dsi99128961cf.646.2024.05.13.05.21.24 for
 <mtsirkin@gapps.redhat.com> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384
 bits=256/256); Mon, 13 May 2024 05:21:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of
 virtio-comment+bounces-4-mst=redhat.com@lists.linux.dev designates
 147.75.48.161 as permitted sender) client-ip=147.75.48.161;
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-FDk6Dj4_NSqvCZp4m06dpg-1; Mon, 13 May 2024 08:16:22 -0400
X-MC-Unique: FDk6Dj4_NSqvCZp4m06dpg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256
 bits) key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested) by mimecast-mx02.redhat.com
 (Postfix) with ESMTPS id 47305101A555 for <mtsirkin@gapps.redhat.com>; Mon,
 13 May 2024 12:16:22 +0000 (UTC)
Received: by smtp.corp.redhat.com (Postfix) id 43970400056; Mon, 13 May 2024
 12:16:22 +0000 (UTC)
Received: from mimecast-mx02.redhat.com
 (mimecast09.extmail.prod.ext.rdu2.redhat.com [10.11.55.25]) by
 smtp.corp.redhat.com (Postfix) with ESMTPS id 0ACAE492BC6 for
 <mtsirkin@redhat.com>; Mon, 13 May 2024 12:16:22 +0000 (UTC)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [170.10.128.131]) (using TLSv1.3 with cipher
 TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519 server-signature
 RSA-PSS (2048 bits)) (No client certificate requested) by
 mimecast-mx02.redhat.com (Postfix) with ESMTPS id E51C529AA3BE for
 <mtsirkin@redhat.com>; Mon, 13 May 2024 12:16:21 +0000 (UTC)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-LL2q2xv6OGCFMH-95wQHWQ-1; Mon,
 13 May 2024 08:16:19 -0400
X-MC-Unique: LL2q2xv6OGCFMH-95wQHWQ-1
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org
 [52.25.139.140]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384
 (256/256 bits)) (No client certificate requested) by sy.mirrors.kernel.org
 (Postfix) with ESMTPS id 791A7B218C5 for <mst@redhat.com>; Mon, 13 May 2024
 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by
 smtp.subspace.kernel.org (Postfix) with ESMTP id B95D814F10C; Mon, 13 May
 2024 12:10:16 +0000 (UTC)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com
 [209.85.166.171]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256
 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org
 (Postfix) with ESMTPS id 3AACC14EC6A for <virtio-comment@lists.linux.dev>;
 Mon, 13 May 2024 12:10:15 +0000 (UTC)
Received: by mail-il1-f171.google.com with SMTP id
 e9e14a558f8ab-36c826d6edeso19943665ab.0 for <virtio-comment@lists.linux.dev>;
 Mon, 13 May 2024 05:10:15 -0700 (PDT)
X-Received: by 2002:a05:6e02:216c:b0:36b:3c85:8b84 with SMTP id
 e9e14a558f8ab-36cc14f839dmr128452325ab.23.1715602214174; Mon, 13 May 2024
 05:10:14 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.10]) by smtp.gmail.com
 with ESMTPSA id 41be03b00d2f7-63411346d46sm6578498a12.79.2024.05.13.05.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Mon, 13 May 2024
 05:10:13 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: virtio-comment@lists.linux.dev, virtio-dev@lists.linux.dev
Cc: david@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/1] balloon: introduce 6 memory statistics
Date: Mon, 13 May 2024 20:10:05 +0800
Message-Id: <20240513121005.459013-2-pizhenwei@bytedance.com>
In-Reply-To: <20240513121005.459013-1-pizhenwei@bytedance.com>
References: <20240513121005.459013-1-pizhenwei@bytedance.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection
 Definition;Similar Internal Domain=false;Similar Monitored External
 Domain=false;Custom External Domain=false;Mimecast External
 Domain=false;Newly Observed Domain=false;Internal User Name=false;Custom
 Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat
 Dictionary=false;Mimecast Threat Dictionary=false;Custom Threat
 Dictionary=false
X-Mimecast-Bulk-Signature: yes
X-Mimecast-Spam-Signature: bulk
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: bytedance.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Expose more memory statistics of the virtual memory subsystem from
guest, it's helpful to analyze the memory performance and pressure
from host side.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 device-types/balloon/description.tex | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/device-types/balloon/description.tex b/device-types/balloon/de=
scription.tex
index a1d9603..bc8e109 100644
--- a/device-types/balloon/description.tex
+++ b/device-types/balloon/description.tex
@@ -305,6 +305,12 @@ \subsubsection{Memory Statistics}\label{sec:Device Typ=
es / Memory Balloon Device
 #define VIRTIO_BALLOON_S_CACHES   7
 #define VIRTIO_BALLOON_S_HTLB_PGALLOC 8
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL  9
+#define VIRTIO_BALLOON_S_OOM_KILL       10
+#define VIRTIO_BALLOON_S_ALLOC_STALL    11
+#define VIRTIO_BALLOON_S_ASYNC_SCAN     12
+#define VIRTIO_BALLOON_S_DIRECT_SCAN    13
+#define VIRTIO_BALLOON_S_ASYNC_RECLAIM  14
+#define VIRTIO_BALLOON_S_DIRECT_RECLAIM 15
         le16 tag;
         le64 val;
 } __attribute__((packed));
@@ -399,6 +405,24 @@ \subsubsection{Memory Statistics Tags}\label{sec:Devic=
e Types / Memory Balloon D
=20
 \item[VIRTIO_BALLOON_S_HTLB_PGFAIL (9)] The number of failed hugetlb page
   allocations in the guest.
+
+\item[VIRTIO_BALLOON_S_OOM_KILL (10)] The number of Out-Of-Memory killer
+  invocations.
+
+\item[VIRTIO_BALLOON_S_ALLOC_STALL (11)] The number of stall count on memo=
ry
+  allocation.
+
+\item[VIRTIO_BALLOON_S_ASYNC_SCAN (12)] The amount of memory that has been
+  scanned asynchronously (in bytes).
+
+\item[VIRTIO_BALLOON_S_DIRECT_SCAN (13)] The amount of memory that has bee=
n
+  scanned directly (in bytes).
+
+\item[VIRTIO_BALLOON_S_ASYNC_RECLAIM (14)] The amount of memory that has b=
een
+  reclaimed asynchronously (in bytes).
+
+\item[VIRTIO_BALLOON_S_DIRECT_RECLAIM (15)] The amount of memory that has =
been
+  reclaimed directly (in bytes).
 \end{description}
=20
 \subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon =
Device / Device Operation / Free Page Hinting}
--=20
2.34.1

