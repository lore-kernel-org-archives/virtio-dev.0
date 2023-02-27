Return-Path: <virtio-dev-return-11307-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A0F79863F0
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 07:35:57 +0000 (UTC)
Date: Mon, 27 Feb 2023 02:35:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230227023514-mutt-send-email-mst@kernel.org>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-3-parav@nvidia.com>
 <20230225180932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811C842A5C55065DABC71BDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811C842A5C55065DABC71BDCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [PATCH 2/3] transport-pci: Split notes of PCI Device Layout
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 27, 2023 at 03:05:46AM +0000, Parav Pandit wrote:
> > >
> > > -Note that only Feature Bits 0 to 31 are accessible through the
> > > +\subsubsection{Legacy Interface: A Note on feature
> > > +bits}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
> > > +Virtio Structure PCI Capabilities / Legacy Interface: A Note on
> > > +feature bits}
> > > +
> > > +Only Feature Bits 0 to 31 are accessible through the
> > >  Legacy Interface. When used through the Legacy Interface,  the
> > > transitional device MUST assume that Feature Bits 32 to 63  are not
> > > acknowledged by the driver.
> > 
> > And you are dropping "Note" here because why? Seems notable in that there
> > are more feature bits, someone might miss this fact.
> The heading is "A Note ..."
> Hence, I dropped the Note from the sentence.
> But if you really care, can add it back...

That's a note as a noun versus note as a verb. Not the same thing.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

