Return-Path: virtio-return-2932-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 28 Feb 2018 22:35:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180228223504-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
 <20180216092412-mutt-send-email-mst@kernel.org>
 <20180224051706.fjemv3etmswgyqjz@debian>
 <20180225204425-mutt-send-email-mst@kernel.org>
 <20180226105111.4rcxkimh6uapywhj@debian>
 <20180226223702-mutt-send-email-mst@kernel.org>
 <20180227014928.ujlres3uuw6rb6vu@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227014928.ujlres3uuw6rb6vu@debian>
Subject: [virtio] Re: [virtio-dev] Re: [PATCH v8 08/16] packed virtqueues: more
 efficient virtqueue layout
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 27, 2018 at 09:49:28AM +0800, Tiwei Bie wrote:
> struct {
> 	__le16 desc_event_off : 15,
> 	       desc_event_wrap : 1;
> 	__le16 desc_event_flags : 2;
> };

I decided on this format in the end. Thanks for the suggestion!

-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

