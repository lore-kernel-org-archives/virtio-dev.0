Return-Path: <virtio-dev-return-12311-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E45C6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 11:27:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 781152ACE5
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 11:27:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63C37986426
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 11:27:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4DADF98641E; Wed, 19 Apr 2023 11:27:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3845D986421
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Apr 2023 11:27:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: M3MSXaqxOb2Nd28KbHI6Hg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681903630; x=1684495630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFqczEftDL2MYvvZFSVmtko2IbvfK3kknmaw5DdyUcc=;
        b=QdEloTGLwPr13MWLDlpyoX6vTI0h0g4SkfVAGmHB5EbFHA0KfYoehjLWR/6bVB8HUl
         4rtaALAsZ/IXuT39ga8mnchGcDQ/wt4ojfpbYqQB8AJ7hNcG6sUcDjYV6n+5kgOsW8FJ
         eZeGPPIJxgAW8LDBrXp++U2JI4cQ9XH0gb+t3a7fM36mF/9XbtMxP85itLeJp5P5aTaS
         lLhynK2rrfU5jldQtqRHVv9phByeTcBrUl5inj/9a55YCXwjHoxa0a2wJJJrsC8PFjb8
         3ndmPPbp2gw2ZmcQy0sbwmWuvJEQVGiKK0+VX4AZrVKwaOYuAQrlMAPfz+YTnesujMau
         dolA==
X-Gm-Message-State: AAQBX9czgrjLmGEA5l10U+aDBM4YMQ8O5zm8OHGXe6GHeAUl1+Q8LnOJ
	+p3LZna+wvEZ5jl7V/9afiCzcqQFLO6YjiI8V6Qav7fcWXmN8spUJbwDWHVxOzLp2/T2lidWxeR
	xoLIjYnOh7jNN1tp3e1/Ch80Gjchr
X-Received: by 2002:a05:600c:cf:b0:3f1:6ef6:c9d7 with SMTP id u15-20020a05600c00cf00b003f16ef6c9d7mr10171397wmm.38.1681903630078;
        Wed, 19 Apr 2023 04:27:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350bZfZLzqWcuQGeyjLLQhUViW7/zzJng1tx8l/wazyhlXN5zl4xFdOvgznUQr/GYGSV0gkUhKQ==
X-Received: by 2002:a05:600c:cf:b0:3f1:6ef6:c9d7 with SMTP id u15-20020a05600c00cf00b003f16ef6c9d7mr10171364wmm.38.1681903629676;
        Wed, 19 Apr 2023 04:27:09 -0700 (PDT)
Date: Wed, 19 Apr 2023 07:27:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230419072522-mutt-send-email-mst@kernel.org>
References: <20230411194220.752355-1-parav@nvidia.com>
 <20230411194220.752355-2-parav@nvidia.com>
 <20230419030057-mutt-send-email-mst@kernel.org>
 <588b201f-8da7-dc6e-d66e-1489914ef051@intel.com>
MIME-Version: 1.0
In-Reply-To: <588b201f-8da7-dc6e-d66e-1489914ef051@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH 1/2] transport-pci: Improve config msix
 vector description

On Wed, Apr 19, 2023 at 04:25:13PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 4/19/2023 3:05 PM, Michael S. Tsirkin wrote:
> > On Tue, Apr 11, 2023 at 10:42:19PM +0300, Parav Pandit wrote:
> > > config_msix_vector is the register that holds the MSI-X vector number
> > > for receiving configuration change related interrupts.
> > > 
> > > It is not "for MSI-X".
> > > 
> > > Hence, replace the confusing text with appropriate one.
> > > 
> > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > 
> > > ---
> > > changelog:
> > > v0->v1:
> > > - added 'here'
> > > - dropped 'receiving'
> > > ---
> > >   transport-pci.tex | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/transport-pci.tex b/transport-pci.tex
> > > index 42be072..cb9fadd 100644
> > > --- a/transport-pci.tex
> > > +++ b/transport-pci.tex
> > > @@ -343,7 +343,8 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
> > >           Driver Feature Bits selected by \field{driver_feature_select}.
> > >   \item[\field{config_msix_vector}]
> > > -        The driver sets the Configuration Vector for MSI-X.
> > > +        The driver writes an MSI-X vector number here for Configuration change
> > > +        interrupts.
> > Hmm I think it's "the vector", not an. And the order of words
> > is unusual. We also don't normally use "writes here". Would
> > 
> > 	Used by the driver to set the MSI-X vector number for Configuration change interrupts.
> > 
> > be equally acceptable?
> Is it better also explain what is a MSI-X vector number here? Like saying
> the offset in the table or the slot number?
> 
> Thanks,
> Zhu Lingshan

It does, in fact, refer to the MSI-X entry. Vector is in fact the
contents of the entry.  The mixup between vector and entry dates back to
PCI spec which has text like
	While more accurately termed “per-entry masking”, masking an MSI-X Table entry is still
	referred to as “vector masking” so similar descriptions can be used for both MSI and MSI-
	X.


> > 
> > 
> > >   \item[\field{num_queues}]
> > >           The device specifies the maximum number of virtqueues supported here.
> > > -- 
> > > 2.26.2
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

