Return-Path: <virtio-dev-return-11564-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B1AC61DA4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6F9E842B69
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69198986717
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 61CA19866FC; Thu,  9 Mar 2023 08:51:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C7E8986700
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 08:51:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETLRpO4UaRJv+Jq2cQ1jDXzLWWERHBPOjdPoPBs2HQY=;
        b=z92rpRvyqzu0/87GoJceTQe/aJX9NLKitkC2sS4Q0j7XUVonEDCkJHid9waSkR14Uj
         Yd2QJTzecCyi8Xr6SQED/6ZdJPFRb7qN3LWhKGVyXV/Ua/jAVG97z7aTJ3ELjmDPWYMp
         2nO3spU/j/FxRILY+FgdDDsFZN/bs8Jcmq1OwOf85Z6LYOxnc0MDGGH8mqfZbregxmc7
         ntgTTTEBWFKT7rsg6Rt/Xgg2eULsFvs8iyXQ5Z3v+Wy9s5ag4Ntx3M8n9fYFhaVqUhbJ
         T4pxqMehuc7SCIEtQpNiucM5P1rODGN+U9dY7dZ+KqiLOv+nu8Qm84M9bJYCq0ArKXQS
         RDSQ==
X-Gm-Message-State: AO0yUKUb4CAUli60Fm1turmFNCI+xJJ0LfAKQl+cqeTSq8EByTbWexoW
	OgSlFygJpVyO2U4oyPcmOU0Bzg==
X-Google-Smtp-Source: AK7set/6Djb1zMP9YhPTkWppkZDJ0L3CO0duyd+NyeHjm4Zil4YeTAqUaIBzL/6AzT6fjqaHkZW0kA==
X-Received: by 2002:a17:902:c14c:b0:19d:74c:78e4 with SMTP id 12-20020a170902c14c00b0019d074c78e4mr18866811plj.55.1678351872801;
        Thu, 09 Mar 2023 00:51:12 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: qemu-devel@nongnu.org,
	virtio-dev@lists.oasis-open.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>,
	xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu,  9 Mar 2023 14:21:01 +0530
Message-Id: <6d0bd7f0e1aeec3ddb603ae4ff334c75c7d0d7b3.1678351495.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1678351495.git.viresh.kumar@linaro.org>
References: <cover.1678351495.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH V3 2/2] docs: vhost-user: Add Xen specific memory mapping support

The current model of memory mapping at the back-end works fine where a
standard call to mmap() (for the respective file descriptor) is enough
before the front-end can start accessing the guest memory.

There are other complex cases though where the back-end needs more
information and simple mmap() isn't enough. For example Xen, a type-1
hypervisor, currently supports memory mapping via two different methods,
foreign-mapping (via /dev/privcmd) and grant-dev (via /dev/gntdev). In
both these cases, the back-end needs to call mmap() and ioctl(), with
extra information like the Xen domain-id of the guest whose memory we
are trying to map.

Add a new protocol feature, 'VHOST_USER_PROTOCOL_F_XEN_MMAP', which lets
the back-end know about the additional memory mapping requirements.
When this feature is negotiated, the front-end will send the additional
information within the memory regions themselves.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 docs/interop/vhost-user.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 1720d681264d..5a070adbc1aa 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -145,6 +145,26 @@ Memory region description
 
 :mmap offset: 64-bit offset where region starts in the mapped memory
 
+When the ``VHOST_USER_PROTOCOL_F_XEN_MMAP`` protocol feature has been
+successfully negotiated, the memory region description contains two extra
+fields at the end.
+
++---------------+------+--------------+-------------+----------------+-------+
+| guest address | size | user address | mmap offset | xen mmap flags | domid |
++---------------+------+--------------+-------------+----------------+-------+
+
+:xen mmap flags: 32-bit bit field
+
+- Bit 0 is set for Xen foreign memory mapping.
+- Bit 1 is set for Xen grant memory mapping.
+- Bit 8 is set if the memory region can not be mapped in advance, and memory
+  areas within this region must be mapped / unmapped only when required by the
+  back-end. The back-end shouldn't try to map the entire region at once, as the
+  front-end may not allow it. The back-end should rather map only the required
+  amount of memory at once and unmap it after it is used.
+
+:domid: a 32-bit Xen hypervisor specific domain id.
+
 Single memory region description
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -864,6 +884,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
+  #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
 
 Front-end message types
 -----------------------
-- 
2.31.1.272.g89b43f80a514


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

