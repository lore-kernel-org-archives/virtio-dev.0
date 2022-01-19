Return-Path: <virtio-dev-return-9141-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8896D98653B
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jan 2022 18:01:25 +0000 (UTC)
Date: Wed, 19 Jan 2022 18:01:00 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <YehR3AN9GpL0LIFt@myrica>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-3-jasowang@redhat.com>
 <Yd6wZ2WMP0FMXWh8@stefanha-x1.localdomain>
 <CACGkMEtb7wGZ8oG-LwUNpFD2pJgEKGx6ttZHgWM686EN4A060A@mail.gmail.com>
 <YeFFr4w+k2ObxgWB@myrica>
 <CACGkMEs_82HexdCw2G8S_L60s1Cu6seZ6n_sGcEUUNnic4NoYA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs_82HexdCw2G8S_L60s1Cu6seZ6n_sGcEUUNnic4NoYA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V2 2/2] virtio-pci: add PASID
 configuration extended capability
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 17, 2022 at 01:57:47PM +0800, Jason Wang wrote:
> How about something like:
> 
> "
> Except for the MSI transactions, the device MUST use PASID TLP prefix
> for the following memory transactions initiated by the virtqueue that
> belong to a virtqueue group if a valid PASID is assigned and PASID is
> enabled in the PASID extended capability:
> 
> \begin{itemize}
> \item Memory Requests (including AtomicOp Requests) with Untranslated
>   Addresses
> \item Address Translation Requests
> \item Page Request Messages
> \end{itemize}
> 
> The device MUST NOT use PASID TLP prefix for the MSI memory
> transactions.
> 

Sure, that looks good. Maybe splitting it would make it easier to explain.
If we force the driver to enable the PASID cap before using PASID:

"The driver MUST NOT assign a PASID to a virtqueue group if the PASID
extended capability is not enabled."

Then the device description is not concerned about the PASID cap:

"If a valid PASID is assigned to a virtqueue group, the device MUST use a
PASID TLP prefix for memory transactions of the following types initiated
by any virtqueue in the group:
  ...

The device MUST NOT use a PASID TLP prefix for MSI memory transactions.
"

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

