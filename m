Return-Path: virtio-return-3054-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 10 Apr 2018 11:30:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180410113007.44377586.cohuck@redhat.com>
In-Reply-To: <1523300322-21989-3-git-send-email-pasic@linux.vnet.ibm.com>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
	<1523300322-21989-3-git-send-email-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH 2/5] consistency: clean up stale  wording for v1.1 terms
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon,  9 Apr 2018 20:58:39 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Occasionally we still use used and available ring instead of Device and
> Driver Area respectively. Same goes for descriptor table with the
> difference that depending on the context we need either Descriptor Area
> or descriptor ring.
> 
> Let's clean these up, at least where the cleanup is trivial.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  content.tex     |   14 +++++++-------
>  packed-ring.tex |   10 ++++++----
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 

> -\drivernormative{\subsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / PAcked Virtqueues / The Virtqueue Descriptor Table}
> +\drivernormative{\subsection}{The Virtqueue Descriptor Ring}{Basic Facilities of a Virtio Device / PAcked Virtqueues / The Virtqueue Descriptor Ring}

While you're touching it anyway: s/PAcked/Packed/ ? (Probably needs a
change in conformance.tex as well.)

>  A driver MUST NOT change a descriptor unless it observes
>  the VIRTQ_DESC_F_USED bit in its \field{flags} being changed.
>  A driver MUST NOT change a descriptor after changing

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

