Return-Path: virtio-return-3088-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 20 Apr 2018 19:28:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180420192339-mutt-send-email-mst@kernel.org>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523300322-21989-5-git-send-email-pasic@linux.vnet.ibm.com>
 <79445753-5c65-3ffb-f84d-578a50037561@redhat.com>
 <e5e2df6e-59cf-9a97-861c-53b0e5160a79@linux.vnet.ibm.com>
 <2b0c61bd-d2f9-3bdb-32de-789e65a5a703@redhat.com>
 <29af1c28-c7b0-a461-3c53-9b029512c6d7@linux.vnet.ibm.com>
 <20180420184651-mutt-send-email-mst@kernel.org>
 <b3946831-bdb2-b1c4-5c47-b917363b0893@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3946831-bdb2-b1c4-5c47-b917363b0893@linux.ibm.com>
Subject: Re: [virtio] [PATCH 4/5] packed-ring: reposition drivernormative on
 driver notifications
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 20, 2018 at 06:22:40PM +0200, Halil Pasic wrote:
> Was, kind of, the point I tried to make. I've (for myself) given up on
> these ideals. That's why I did not bother to think about isn't that sentence
> normative section material. And I don't intend to clean up normative
> vs non-normative.

Makes sense.

We do need to keep RFC2119 keywords out of the rest of the text simply to
avoid confusing people - from experience if we don't then during public
review people jump on it immediately and say hey this must go into the
normative section. It's just something that's easy to spot :)

-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

