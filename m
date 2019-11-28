Return-Path: virtio-return-3418-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 28 Nov 2019 17:54:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191128175459.1888efdc.cohuck@redhat.com>
In-Reply-To: <20191127213240.34106-1-mst@redhat.com>
References: <20191127213240.34106-1-mst@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio] [PATCH v2] virtio_pci_cap64: bar/BAR cleanups
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Christophe de Dinechin <cdupontd@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 27 Nov 2019 16:33:07 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> When we mean PCI register we should say BAR.
> When we mean a virtio config register we should say \field{cap.bar}.
> 
> Finally, offset_hi/length_hi are not within the cap structure.
> 
> Tweak wording slightly: "A,B,C" are fields, there's no need
> to say that.
> 
> Reported-by: Christophe de Dinechin <cdupontd@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> changes from v1:
> 	minor wording tweak
> 
>  content.tex | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

