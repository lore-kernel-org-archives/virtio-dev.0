Return-Path: virtio-return-2954-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <20180301005944-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 17:13:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180301005944-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <abced806-38f8-6cf2-7fb0-b2f29996d665@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH v8 to v9 incremental] packed ring layout spec
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 03/01/2018 12:10 AM, Michael S. Tsirkin wrote:
> Here's an incremental patch since v8, for ease of review.
> I did my best to address all outstanding comments.
> 
> Changelog:
> 
>  packed-ring: clarify wording on s/g conformance
>  split-ring: typo: aligment
>  packed-ring: typo: aligment
>  packed-ring: clarify multi-buffer requests
>  packed-ring: necessary, not sufficient condition
>  packed-ring: support skipping used descritors
>  packed-ring: fix pseudo code
>  packed-ring: format pseudocode using spaces
>  packed-ring: drop << in pseudocode
>  packed-ring: clarify event suppression format
>  packed-ring: chained descriptors are always on
>  VIRTIO_F_NOTIFICATION_DATA: switch to bitfields
>  introduction: document bitfield notation
>  VIRTIO_F_NOTIFICATION_DATA: minor cleanups
>  content: VIRTIO_F_NOTIFICATION_DATA is option
>  VIRTIO_F_NOTIFICATION_DATA: improve formatting
> 
> Note that I had to move notification format for ccw and mmio out to a
> separate file - latex seems to get confused otherwise.  A clean patchset
> to follow.
> 
> Incrementally redlined pdf is available at the
> virtio-doc repository as virtio-v1.1-w08-to-wd09-diff.pdf
> 
> ---
>

Run trough this. My first impression is changes look good. I will try to
go trough the whole thing again during the next days.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

