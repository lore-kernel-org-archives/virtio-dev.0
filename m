Return-Path: <virtio-dev-return-11415-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DB8C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 08:11:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3EF452B055
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 08:11:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24EEA986794
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 08:11:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0E1C298678B; Fri,  3 Mar 2023 08:11:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED56898678C
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 08:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677831073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fvhd/CjcSxSDcDRaW2+sffBUEEjHgUO/YNJh3LIGeo=;
        b=wF9EwdAp5FiGXEQQgAAIyEc6vui+6+VQApy/eq79/jClH1IzpMO2mSC8enqV29m17E
         erAi0nVa3uAIm23hJwkq7HA7o20GA8cPCuRBOzMCrRjAzhN5Dir7Xuk0qfDOTI1gKaZc
         b5gUkeZgfyHw6sulin+BYEJZGRjLmZpb6tby2PrkAqzL5R2G4LcEJZCh1lz1pIXdMfWI
         oRWfXNFvtuMLAxhXnX6+LEReZjiPSHiKaUeB0g4met99F0g3tHHRAu+jMxqU8XQ1SMdp
         Q4UcMUZWzqUT/4jozFuXKZSjvgiFVcRpxJe8q+TLMoFy7ktRGVHHhp6Zv+CL9LkDi/6C
         +iyA==
X-Gm-Message-State: AO0yUKXeogSyMx77WF8cPK3PSuYEVuCGjH1sYE9pVh5zBHtC6GqNNvjd
	to2la6hFcdgupbt4cKHHSTRq6w==
X-Google-Smtp-Source: AK7set9pwBoUqmQ648WFuJ9eNFtOCWgufbD4voyt0olq5F6HoZcChJO6380uERtNwEr//sigsXtTHg==
X-Received: by 2002:a17:902:e745:b0:19c:eaab:653d with SMTP id p5-20020a170902e74500b0019ceaab653dmr5095605plf.15.1677831072831;
        Fri, 03 Mar 2023 00:11:12 -0800 (PST)
Date: Fri, 3 Mar 2023 13:41:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Message-ID: <20230303081110.e6waldur3i7lzl6e@vireshk-i7>
References: <Y/9zkDAS4odz93GM@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/9zkDAS4odz93GM@fedora>
Subject: Re: [virtio-dev] [RFC QEMU] docs: vhost-user: Add custom memory
 mapping support

On 01-03-23, 10:47, Stefan Hajnoczi wrote:
> Resend - for some reason my email didn't make it out.

How about this (will send a formal patch later).

Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue Feb 21 14:36:30 2023 +0530

    docs: vhost-user: Add Xen specific memory mapping support

    The current model of memory mapping at the back-end works fine where a
    standard call to mmap() (for the respective file descriptor) is enough
    before the front-end can start accessing the guest memory.

    There are other complex cases though where the back-end needs more
    information and simple mmap() isn't enough. For example Xen, a type-1
    hypervisor, currently supports memory mapping via two different methods,
    foreign-mapping (via /dev/privcmd) and grant-dev (via /dev/gntdev). In
    both these cases, the back-end needs to call mmap() and ioctl(), and
    need to pass extra information via the ioctl(), like the Xen domain-id
    of the guest whose memory we are trying to map.

    Add a new protocol feature, 'VHOST_USER_PROTOCOL_F_XEN_MMAP', which lets
    the back-end know about the additional memory mapping requirements.
    When this feature is negotiated, the front-end can send the
    'VHOST_USER_SET_XEN_MMAP' message type to provide the additional
    information to the back-end.

    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 docs/interop/vhost-user.rst | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 3f18ab424eb0..8be5f5eae941 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -258,6 +258,24 @@ Inflight description

 :queue size: a 16-bit size of virtqueues

+Xen mmap description
+^^^^^^^^^^^^^^^^^^^^
+
++-------+-------+
+| flags | domid |
++-------+-------+
+
+:flags: 64-bit bit field
+
+- Bit 0 is set for Xen foreign memory memory mapping.
+- Bit 1 is set for Xen grant memory memory mapping.
+- Bit 2 is set if the back-end can directly map additional memory (like
+  descriptor buffers or indirect descriptors, which aren't part of already
+  shared memory regions) without the need of front-end sending an additional
+  memory region first.
+
+:domid: a 64-bit Xen hypervisor specific domain id.
+
 C structure
 -----------

@@ -867,6 +885,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
+  #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17

 Front-end message types
 -----------------------
@@ -1422,6 +1441,23 @@ Front-end message types
   query the back-end for its device status as defined in the Virtio
   specification.

+``VHOST_USER_SET_XEN_MMAP``
+  :id: 41
+  :equivalent ioctl: N/A
+  :request payload: Xen mmap description
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_XEN_MMAP`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end to set the
+  Xen hypervisor specific memory mapping configurations at the back-end.  These
+  configurations should be used to mmap memory regions, virtqueues, descriptors
+  and descriptor buffers. The front-end must send this message before any
+  memory-regions are sent to the back-end via ``VHOST_USER_SET_MEM_TABLE`` or
+  ``VHOST_USER_ADD_MEM_REG`` message types. The front-end can send this message
+  multiple times, if different mmap configurations are required for different
+  memory regions, where the most recent ``VHOST_USER_SET_XEN_MMAP`` must be used
+  by the back-end to map any newly shared memory regions.
+

 Back-end message types
 ----------------------

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

