Return-Path: <virtio-dev-return-11565-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746D0C64EC4
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D170C67048
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C87B29866FD
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 08:51:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BB81B9866C1; Thu,  9 Mar 2023 08:51:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA6449866F3
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 08:51:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoLKXeFqXx7KD6iGKmnIOLpPoXbmwYAjlvz4PZEVkSA=;
        b=157l126Y94BtlDnEiHSRM7iA10FC+g31Q3e5aCSTgP9CI+4FadqyGyKNmWjvtnIaPu
         Go5gtcchoAMPdU4yz2XWabUDDp3IIJWIDfQBlDVBdTQhdIq5uJaSRgrEY+kZiv4KrZuZ
         hd8dl+3eLJ/KIS94F4raPs3jHEgIl56EtrfrW2mJ3/v8JAfcePI9R9kgthHCvGevh2cY
         /Tfxw97/KnSRzNZM0YJO1tHrJ/993qHn3PsgjFJaVcmTlQF0n90y87nGZ+kkKXeHmTj5
         u64+QFL8R22Dzgivkqu7OdKO069EmRkJ0hIpqcxh6t55kXn7Aw3dz4/cOq3FXWKnNP5W
         SeJA==
X-Gm-Message-State: AO0yUKUi/JcJKwzOwhRp1qljo08nyr+R2n6a6iGLSKnMX/y1FqE6xngz
	wAgsB27EDsLdwYoN71Eu16MhDg==
X-Google-Smtp-Source: AK7set+XV8TLjm8RgYTqNTMsI0CUUR3mMd7SAtAvTG0E9Jgb0eD9NpjnCNEhIm4iXn1YYGJQOpSeoQ==
X-Received: by 2002:a17:902:e80f:b0:19e:747e:813e with SMTP id u15-20020a170902e80f00b0019e747e813emr23672384plg.23.1678351901368;
        Thu, 09 Mar 2023 00:51:41 -0800 (PST)
Date: Thu, 9 Mar 2023 14:21:38 +0530
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
Message-ID: <20230309085138.jsn5qwlwvtbtjszv@vireshk-i7>
References: <7c3c120bcf2cf023e873800fd3f55239dd302e38.1678100850.git.viresh.kumar@linaro.org>
 <20230306153451.GB51288@fedora>
 <20230307054336.uvky5d7q2qqlxdcv@vireshk-i7>
 <20230307162237.GI124259@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307162237.GI124259@fedora>
Subject: [virtio-dev] Re: [PATCH V2] docs: vhost-user: Add Xen specific memory mapping
 support

On 07-03-23, 11:22, Stefan Hajnoczi wrote:
> VHOST_USER_IOTLB_MSG probably isn't necessary because address
> translation is not required. It will also reduce performance by adding
> extra communication.
> 
> Instead, you could change the 1 memory region : 1 mmap relationship that
> existing non-Xen vhost-user back-end implementations have. In Xen
> vhost-user back-ends, the memory region details (including the file
> descriptor and Xen domain id) would be stashed away in back-end when the
> front-end adds memory regions. No mmap would be performed upon
> VHOST_USER_ADD_MEM_REG or VHOST_USER_SET_MEM_TABLE.
> 
> Whenever the back-end needs to do DMA, it looks up the memory region and
> performs the mmap + Xen-specific calls:
> - A long-lived mmap of the vring is set up when
>   VHOST_USER_SET_VRING_ENABLE is received.
> - Short-lived mmaps of the indirect descriptors and memory pointed to by
>   the descriptors is set up by the virtqueue processing code.
> 
> Does this sound workable to you?

Sounds good. I have sent a proposal (v3) based on that now.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

