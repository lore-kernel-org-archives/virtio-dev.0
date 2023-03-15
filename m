Return-Path: <virtio-dev-return-11615-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A42C61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 05:17:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 506852AFF6
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 05:17:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D0349863E1
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 05:17:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 297D6984092; Wed, 15 Mar 2023 05:17:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1476F9863D9
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 05:17:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678857475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8QmKYcJg57HlzpunFUH9MGPifRoNDq8hXq0hFkxBNA=;
        b=bDr6SwzmQ+WHgUexu44PBH0GbqjAVdXtqw39QFAGHGT5L6hott1YCfJK+4DLEaH6JD
         bIflcDDPXe+D0pTD+Te1fiU9LfxNuEtoRypFAWUhtsGht2jd0RWHG8mVRxZ1MYLOg7hH
         pf3Jxc0sq3MI96so0EGxsrF9WsqhI4VjATdmuqOPCK2B+ga4mdpyzp594dFsyA9+7q3O
         6SRKD004AjLVzjX7qaSFR2A5cahObEEiDqGoVdvVq6AF95ETUjohb58bwuF44mDr+NHY
         IH7otaQ4QdS60UpdzA4+GLVQ7ocj7stdpvM0E6Qzi++NTEFYoOBzd2jtw+pBR+XFnaeP
         Fyew==
X-Gm-Message-State: AO0yUKVmBFXLV4//h5RoGriYOacSNxVALWjlstblniGTrdnNjt2aSNC6
	sV+Xl1uc+2XynOCmI6JVjG5z6g==
X-Google-Smtp-Source: AK7set+v+08YLmgVZIkdUoqQNIHkvJTCWU5NZ9zfOm8OmZpJiNuz6CJzunAVmSRk/ShmWB32e+7zgw==
X-Received: by 2002:a05:6a20:7a1f:b0:d6:f0:85a with SMTP id t31-20020a056a207a1f00b000d600f0085amr1351227pzh.17.1678857475344;
        Tue, 14 Mar 2023 22:17:55 -0700 (PDT)
Date: Wed, 15 Mar 2023 10:47:52 +0530
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
Message-ID: <20230315051752.2owlp26mq72dqel2@vireshk-i7>
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
> 
> V2->V3:
> - Remove the extra message and instead update the memory regions to carry
>   additional data.
> 
> - Drop the one region one mmap relationship and allow back-end to map only parts
>   of a region at once, required for Xen grant mappings.
> 
> - Additional cleanup patch 1/2.

Stefan,

Does this version look better ?

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

