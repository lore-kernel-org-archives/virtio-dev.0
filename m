Return-Path: <virtio-dev-return-10666-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD7659866B4
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Jan 2023 05:01:09 +0000 (UTC)
Date: Thu, 26 Jan 2023 00:01:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230125235026-mutt-send-email-mst@kernel.org>
References: <20230112212550.763889-1-parav@nvidia.com>
 <20230125190454.043e54e0.pasic@linux.ibm.com>
 <20230125155204-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810534C4518320B28BC9D6DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54819A070E3D374E0BDBCEA2DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819A070E3D374E0BDBCEA2DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 25, 2023 at 11:46:58PM +0000, Parav Pandit wrote:
> I clicked too early while typing.
> Since DEL operation doesn't synchronize with the data path of device and driver, at some point a packet in pipe can be still received with removed VLAN.
> So may be the note was added.
> But for sure ADD should not be best effort basis.

why are you sure? dropping a packet or two while reconfiguring might not be a big deal either.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

