Return-Path: virtio-return-2928-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 28 Feb 2018 17:09:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180228170932.6285fba2.cohuck@redhat.com>
In-Reply-To: <20180228171504-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
	<20180216092412-mutt-send-email-mst@kernel.org>
	<20180224051706.fjemv3etmswgyqjz@debian>
	<20180225204425-mutt-send-email-mst@kernel.org>
	<20180226105111.4rcxkimh6uapywhj@debian>
	<20180226223702-mutt-send-email-mst@kernel.org>
	<20180227014928.ujlres3uuw6rb6vu@debian>
	<20180227221208-mutt-send-email-mst@kernel.org>
	<20180228091914.jfymbyxln7ti5r3e@debian>
	<20180228171504-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [virtio-dev] Re: [PATCH v8 08/16] packed virtqueues: more
 efficient virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 28 Feb 2018 17:20:29 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> I agree.  I think I will stop using the bitfields - they seem to
> cause too much confusion. Just
> 
> struct event {
>  	__le16 event_desc; /* bits 0-14: desc_off. 15 - desc_wrap. */
> 	__le16 event_flags; /* bits 0-1: event_flags, 2-15 - reserved */
> };

Looks sensible; but while you're add it, drop the leading underscores
as well? The spec only talks about 'le16' and friends.

[Also, reserved-and-to-be-ignored or reserved-and-must-be-0?]

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

