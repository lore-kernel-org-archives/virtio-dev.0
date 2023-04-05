Return-Path: <virtio-dev-return-12005-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56667C76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 08:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 794DE2B055
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 08:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58CC99865AB
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 08:05:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3DDAA983DE1; Wed,  5 Apr 2023 08:05:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36A839865A7
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 08:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680681915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG5PZXaUKhRxajyfEHYthrg54Lo1xoJ4el5+xnkywpQ=;
        b=rqIrSDXKGR0mQeQTk6Lrpiogbt6lrTWJ52FWZ59HNO9IHtTQJLZBEc7jXp08ADjLBq
         vsgKa9+E3up8Qtk6l+Cmv9+VP4bfpx4NHhZyVw4wxGZmjoKzMgwvQa5Opd89ZW1+YGha
         exhujd7G9QoZ3bh+eO6CKR3twc1Y+kUVlqu/c0lcpor0Z31bO4SzwF+zCrl0Pps5Fwwj
         H0TYJGVLxCuvnaqHkTM2hRkjU2vuA/m+MjPdSRG9ci7bjtw7oyYm+UC64j+s9YHhewA0
         F/GOPps2b8HPh8Lanj5Rb9/6SVcHFsHKWbsil76Yx1Er5r8UPPofhnw1GpjsCs51j2Uc
         WJ9Q==
X-Gm-Message-State: AAQBX9cQqEVXn3jBtmFFBv4I6GhmuCWpKo1tkir7a7NrVwN5Fj8HkrLr
	U4TWLDEwiLLbOvTbb85bOGWKuA==
X-Google-Smtp-Source: AKy350ZJ1bbwKNRCdYkOTrVTQ+pN4bqMvXPSEwXvqfgJHgfHdmB+v/yBFWMjTYFvTH5cPlfe9/Nq/w==
X-Received: by 2002:a05:6a20:2d96:b0:dd:bf6a:4609 with SMTP id bf22-20020a056a202d9600b000ddbf6a4609mr3559565pzb.49.1680681915648;
        Wed, 05 Apr 2023 01:05:15 -0700 (PDT)
Date: Wed, 5 Apr 2023 13:35:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Message-ID: <20230405080512.nvxiw4lv7hyuzqej@vireshk-i7>
References: <cover.1678351495.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678351495.git.viresh.kumar@linaro.org>
Subject: [virtio-dev] Re: [PATCH V3 0/2] qemu: vhost-user: Support Xen memory mapping
 quirks

On 09-03-23, 14:20, Viresh Kumar wrote:
> Hello,
> 
> This patchset tries to update the vhost-user protocol to make it support special
> memory mapping required in case of Xen hypervisor.
> 
> The first patch is mostly cleanup and second one introduces a new xen specific
> feature.

Can we apply this now ? I have developed code for rust-vmm crates
based on this and we need to get this merged/finalized first before
merging those changes.

Thanks.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

