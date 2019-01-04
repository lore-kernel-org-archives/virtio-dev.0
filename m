Return-Path: virtio-dev-return-5249-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60210985DA4
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Jan 2019 11:26:35 +0000 (UTC)
Date: Fri, 4 Jan 2019 12:26:26 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <1546585913-34804-2-git-send-email-wei.w.wang@intel.com>
References: <1546585913-34804-1-git-send-email-wei.w.wang@intel.com>
	<1546585913-34804-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190104122626.1bdf019c@oc2783563651>
Subject: Re: [virtio-dev] [PATCH v2 1/2] virtio-balloon: tweak
 config_changed implementation
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri,  4 Jan 2019 15:11:52 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> virtio-ccw has deadlock issues with reading the config space inside the
> interrupt context, so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> The config_read_bitmap is used as a flag to the workqueue callbacks
> about the related config fields that need to be read.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

