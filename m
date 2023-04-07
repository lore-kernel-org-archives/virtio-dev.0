Return-Path: <virtio-dev-return-12059-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E104C6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:32:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DB4E22B142
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:32:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C60C19865D9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:32:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B47EF983F7B; Fri,  7 Apr 2023 11:32:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A41E39865D7
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 11:32:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: MblvIQCnMAuny2Aoq7FWCg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680867160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CaufME2mCrPd6rGoC7bssgbcqUZZLFly/vo+i5ftUQ=;
        b=rkGHv4E7pUXFLD0qdIFEsztgzOQ1LDVgVrb/dfxoHYJbLkj/HXyJfcWnFcTL538pJl
         Mipb8LTXwYIkwVfBRu2iaweNughR5IfZBQ1juNkBy8ZPYpTeiGWNiNi9jDFv7OSR9F+J
         GRf7It+imcfQHPSuLp6C3GynBQ/4YJ0Dxh5XuClDvp9Sr8PZExqUCphG17p+ZuY+z3S/
         gVOLD8Lze+Yom2pOeYEC/oW+JdJyLa442V7D3uvqEk06wtqkr5sAFb0tRpck8g8iN797
         mTOIyD0dPgL7YbeYQq8qq95bMpz4K5ti3HWBuLXfFdrbQpTRbuDofGkm3A9MvyPTfpau
         30kQ==
X-Gm-Message-State: AAQBX9dJ0z1XwsdgpxVHgkt22M/V6j/zH2XM5kPW5m+utGKHhjcZONLX
	5fdgj+PIxhwkZtkEI+lfiXC8ckPCIbIOgh4lx3dBLhArErikaB+42hpZaYihrlW/bBy1jI2StIE
	DewDJcCy8shWvgAww/bqFTAQ2Bbqb
X-Received: by 2002:a05:600c:2943:b0:3ed:b4e8:630f with SMTP id n3-20020a05600c294300b003edb4e8630fmr1089017wmd.10.1680867159868;
        Fri, 07 Apr 2023 04:32:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZHcIuLc7Gwhne2myaNQ/5rib+535JHfabvrXi4KYaX1yZoDpHNY0tOJQWqN46Mxn5HlvyahA==
X-Received: by 2002:a05:600c:2943:b0:3ed:b4e8:630f with SMTP id n3-20020a05600c294300b003edb4e8630fmr1089003wmd.10.1680867159585;
        Fri, 07 Apr 2023 04:32:39 -0700 (PDT)
Date: Fri, 7 Apr 2023 07:32:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230407073027-mutt-send-email-mst@kernel.org>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-11-parav@nvidia.com>
 <20230405051637-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481035B8C5D113CA76CB6D9DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481035B8C5D113CA76CB6D9DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v12 10/10] virtio-net: Describe RSS
 using rss rq id

On Wed, Apr 05, 2023 at 01:02:24PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 5, 2023 5:18 AM
> 
> > following format for \field{command-specific-data}:
> > >  \begin{lstlisting}
> > > +struct rss_rq_id {
> > > +   le16 vqn_1_16: 15; /* Bits 1 to 16 of the vq index */
> > 
> > Do you want to then call this vq_index_1_16 ?
> Yes. will change.
> 
> > And in the comment I would just write virtqueue index.
> > 
> Why do you prefer longer to name here instead of abbreviation?

Eschew abbreviation is standard advice for writers.
Full names reduce the cognitive load - reader has less terms to
remember to be able to understand the spec.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

