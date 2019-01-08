Return-Path: SRS0=cDPr=PQ=linuxfoundation.org=gregkh@kernel.org
Date: Tue, 08 Jan 2019 00:10:34 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 1/3] virtio-balloon: tweak config_changed implementation
Message-ID: <20190108071034.GA32048@kroah.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com> <1546923005-40517-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546923005-40517-2-git-send-email-wei.w.wang@intel.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 08, 2019 at 12:50:03PM +0800, Wei Wang wrote:
> virtio-ccw has deadlock issues with reading the config space inside the
> interrupt context, so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> The config_read_bitmap is used as a flag to the workqueue callbacks
> about the related config fields that need to be read.
> 
> The cmd_id_received is also renamed to cmd_id_received_cache, and
> the value should be obtained via virtio_balloon_cmd_id_received.
> 
> Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/virtio/virtio_balloon.c | 98 +++++++++++++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 33 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
