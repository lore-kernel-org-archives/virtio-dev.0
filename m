Return-Path: <mst@redhat.com>
Date: Tue, 5 Jul 2022 09:56:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 0/7] Introduce device group and device management
Message-ID: <20220705095514-mutt-send-email-mst@kernel.org>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220426225824.5918-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 27, 2022 at 01:58:17AM +0300, Max Gurtovoy wrote:
> Hi,
> A device group definition will help extending the virtio specefication for
> various future features that require a notion of grouping devices together or
> managing devices inside a group. A device group include one or more virtio devices.
> For now, only support for type 1 device group was added.

How about posting a new version? I frankly think between the
hardware hack I proposed and the new admin queue transport
proposal, we do not need to work hard to save
on writeable registers and so for starters at least
we can just use feature bits instead of the query capability
command.

Other issues I feel we have agreed on.


-- 
MST

