Return-Path: <mst@redhat.com>
Date: Tue, 8 Feb 2022 09:04:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
Message-ID: <20220208085915-mutt-send-email-mst@kernel.org>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
 <d9c93540-4838-c18e-12c6-9ef4dc0028de@nvidia.com>
 <20220207111649-mutt-send-email-mst@kernel.org>
 <e29a241b-ebd6-ccb5-1f8c-1ca7fad471d9@nvidia.com>
 <20220208014332-mutt-send-email-mst@kernel.org>
 <d4265ec1-8eab-0a53-f2a5-3764d6e2cda5@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <d4265ec1-8eab-0a53-f2a5-3764d6e2cda5@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 08, 2022 at 10:34:24AM +0200, Max Gurtovoy wrote:
> "Admin virtqueue is one of the management interface that used to send administrative
> commands to manipulate various features of the *device* and/or to manipulate
> various features, if possible, of *another device* within the same group"
> 
> It's not only for groups.

First this sentence is unclear what does "to manipulate" refer to?
What is done to manipulate these things?
I think the vq is to send commands. The commands are to manipulate etc.
So pls cut this up and use shorter sentences please.

And I think the vq is useful mostly for groups. But yes, thinkably if
admin commands are submitted via e.g. MMIO then they can refer to the
same device where they are sent, not to a group.  And this is exactly
why Cornelia's suggesting a way to differentiate.  We should not need a
completely separate command just because it's going to the same device
and not to another one.

-- 
MST

