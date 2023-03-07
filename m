Return-Path: <virtio-dev-return-11464-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CADEC678DB
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 05:43:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4C40C26A2C
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 05:43:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CE689866CC
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 05:43:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 11E27983E53; Tue,  7 Mar 2023 05:43:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EDC6D9866C2
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Mar 2023 05:43:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678167819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyZwio1/+xEWEzxkU6lojpUS2ztMZWUFHUjMcU1o9Ac=;
        b=WJFABwfw0l7uQStTOObTnnkPYw5IJhG9UHx+qV9dcz4VC0t+yH2qrTEEpZNRLkOQlA
         YF3jrPeyQoFzKECJ/JPFZKBbXeexZLtWw2Wrb+xjaKy9UTj5SjG8nHTookyPd1qMlgq6
         acixeq401CtJiehPIbGagHybAASDnw8b9sGxEz/Z0X1+j6zgyGIStmbaL+ZDLELPuXvy
         7Vt55qXpyK/yTgsVaHqCbx6+gODR8OYAI36JmOxnrdwSZmN98E2n3u9vg+WmW9mIscX4
         Ge7M7GgzJ152EfNy2M6fGc09tgfDwkyIotLyaDYLycF4b7eix2mQmueB09kNdqGXNNTL
         r6xA==
X-Gm-Message-State: AO0yUKWml3tmWF8adBXq2l0awstOCdyPRM6qZHW7Ihnib8ykVuIjD1HR
	cmOVDlbO26dpEed1kQt6JTFEfg==
X-Google-Smtp-Source: AK7set89vFW4+ayrW7cytv4tRdqoqnfUXD2/9IyuD77nfB09OVscnz1hGiNeFSav+nWeZHFOSm9Lqg==
X-Received: by 2002:a05:6a20:7d88:b0:cc:a5d6:4471 with SMTP id v8-20020a056a207d8800b000cca5d64471mr17965217pzj.58.1678167819311;
        Mon, 06 Mar 2023 21:43:39 -0800 (PST)
Date: Tue, 7 Mar 2023 11:13:36 +0530
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
Message-ID: <20230307054336.uvky5d7q2qqlxdcv@vireshk-i7>
References: <7c3c120bcf2cf023e873800fd3f55239dd302e38.1678100850.git.viresh.kumar@linaro.org>
 <20230306153451.GB51288@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306153451.GB51288@fedora>
Subject: [virtio-dev] Re: [PATCH V2] docs: vhost-user: Add Xen specific memory mapping
 support

On 06-03-23, 10:34, Stefan Hajnoczi wrote:
> On Mon, Mar 06, 2023 at 04:40:24PM +0530, Viresh Kumar wrote:
> > +Xen mmap description
> > +^^^^^^^^^^^^^^^^^^^^
> > +
> > ++-------+-------+
> > +| flags | domid |
> > ++-------+-------+
> > +
> > +:flags: 64-bit bit field
> > +
> > +- Bit 0 is set for Xen foreign memory memory mapping.
> > +- Bit 1 is set for Xen grant memory memory mapping.
> > +- Bit 2 is set if the back-end can directly map additional memory (like
> > +  descriptor buffers or indirect descriptors, which aren't part of already
> > +  shared memory regions) without the need of front-end sending an additional
> > +  memory region first.
> 
> I don't understand what Bit 2 does. Can you rephrase this? It's unclear
> to me how additional memory can be mapped without a memory region
> (especially the fd) is sent?

I (somehow) assumed we will be able to use the same file descriptor
that was shared for the virtqueues memory regions and yes I can see
now why it wouldn't work or create problems.

And I need suggestion now on how to make this work.

With Xen grants, the front end receives grant address from the from
guest kernel, they aren't physical addresses, kind of IOMMU stuff.

The back-end gets access for memory regions of the virtqueues alone
initially.  When the back-end gets a request, it reads the descriptor
and finds the buffer address, which isn't part of already shared
regions. The same happens for descriptor addresses in case indirect
descriptor feature is negotiated.

At this point I was thinking maybe the back-end can simply call the
mmap/ioctl to map the memory, using the file descriptor used for the
virtqueues.

How else can we make this work ? We also need to unmap/remove the
memory region, as soon as the buffer is processed as the grant address
won't be relevant for any subsequent request.

Should I use VHOST_USER_IOTLB_MSG for this ? I did look at it and I
wasn't convinced if it was an exact fit. For example it says that a
memory address reported with miss/access fail should be part of an
already sent memory region, which isn't the case here.

> This message modifies the behavior of subsequent
> VHOST_USER_SET_MEM_TABLE and VHOST_USER_ADD_MEM_REG messages. The memory
> region structs can be extended and then VHOST_USER_SET_XEN_MMAP isn't
> needed.
> 
> In other words:
> 
>   When VHOST_USER_PROTOCOL_F_XEN_MMAP is negotiated, each "Memory
>   regions description" and "Single memory region description" has the
>   following additional fields appended:
> 
>   +----------------+-------+
>   | xen_mmap_flags | domid |
>   +----------------+-------+

This looks fine.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

