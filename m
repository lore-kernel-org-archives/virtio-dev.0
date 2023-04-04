Return-Path: <virtio-dev-return-11967-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FE2C761AF
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 12:43:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6BEA02A8E4
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 12:43:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B944986418
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 12:43:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4DD569863E6; Tue,  4 Apr 2023 12:43:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E1D19863ED
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 12:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: _uXRvbNtNdm-jNUDWah6cw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680612216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCAXKP/Snwk0r7y93pfN0nz6yssYFNUrhdX7W0lWj8k=;
        b=uNk5xVbdHAP4ez5ou2wpIIVMvLG7PmeL9VX04oEsbsr44mRJu3uwAMgT6/CGtON1UT
         mUkifiqLih/CCLDU6Cl8a8zFoE/k9V4ZAH4oxXBVl4dGP7VOUcjESl6QeLdDjgvcQdMR
         xZzZSxhxxjjA2ATydlNp1xcKsrpi8RDv6Mg9iZo91FPAEVmzwxi7C3B/nZV7n2C2iAJL
         bEfG/Fv9b5r9WUecqza1JaIZF6iGi6rNxGtNsOJgGekKyuhCrupzchhh9Dfa4CaGmveD
         q7uh+ypsmv23byQpuPMt3bdQj9Ym0YtOQDiWNzdXnIEGce+fLjiezkY1Mnj3ZmYh2SH+
         iqjw==
X-Gm-Message-State: AAQBX9eScyjRQQ3eYVQLKEcmrdcJP9FggUMyfYRGYt876R4DgTpLmRz2
	I6Nn02FW0mZFCUfOm1ejixv3LweR7CEz98GrhigGRQdM3DpdT+5VhvXVVoiztojOS494tawyL6V
	WpgiF19kU3FDJlStXNffh6G0/liUF
X-Received: by 2002:a17:906:4943:b0:947:d9b1:89a1 with SMTP id f3-20020a170906494300b00947d9b189a1mr1958902ejt.44.1680612216556;
        Tue, 04 Apr 2023 05:43:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y+VkEzGKsWLfXijf5BPpHK7SmyWKgr9n80ngusKGCx3vDBpA+91T+2wrL/dYXiBmUMdEK2DA==
X-Received: by 2002:a17:906:4943:b0:947:d9b1:89a1 with SMTP id f3-20020a170906494300b00947d9b189a1mr1958885ejt.44.1680612216281;
        Tue, 04 Apr 2023 05:43:36 -0700 (PDT)
Date: Tue, 4 Apr 2023 08:43:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230404084126-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
 <87jzysjd4g.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87jzysjd4g.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Tue, Apr 04, 2023 at 09:54:55AM +0200, Cornelia Huck wrote:
> On Tue, Apr 04 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Mar 31, 2023 at 01:58:31AM +0300, Parav Pandit wrote:
> >> PCI device configuration space for capabilities is limited to only 192
> >> bytes shared by many PCI capabilities of generic PCI device and virtio
> >> specific.
> >> 
> >> Hence, introduce virtio extended capability that uses PCI Express
> >> extended capability.
> >> Subsequent patch uses this virtio extended capability.
> >> 
> >> Co-developed-by: Satananda Burla <sburla@marvell.com>
> >
> > What does it "Co-developed-by" mean exactly that Signed-off-by
> > does not?
> 
> AIUI, "Co-developed-by:" is more akin to a second "Author:", i.e. to
> give attribution. (Linux kernel rules actually state that any
> "Co-developed-by:" must be followed by a "Signed-off-by:" for that
> author, but we don't really do DCO here, the S-o-b is more of a
> convention.)


Actually, we might want to generally, to signify agreement to the IPR.
How about adding this to our rules?  But in this case Satananda Burla is
a TC member so yes, no problem.

> >
> >
> >> Signed-off-by: Parav Pandit <parav@nvidia.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

