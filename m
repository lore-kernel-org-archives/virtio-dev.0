Return-Path: <mst@redhat.com>
Date: Thu, 15 Dec 2022 04:09:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] RE: [PATCH v8 8/9] admin: command list discovery
Message-ID: <20221215023955-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-9-mst@redhat.com>
 <SN6PR11MB3517ECBE658C18BD9B7E355CFF0A9@SN6PR11MB3517.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <SN6PR11MB3517ECBE658C18BD9B7E355CFF0A9@SN6PR11MB3517.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Uminski, Piotr" <Piotr.Uminski@intel.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Jani, Nrupal" <nrupal.jani@intel.com>, "Yuan, Hang" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 21, 2022 at 11:06:14AM +0000, Uminski, Piotr wrote:
> Instead of a bit-coded list of supported commands, can we just use an array of supported command values? It allows us to use non-contiguous command coding and checking how big  is an array:       le32 device_admin_cmds[];

Interesting, what's the usecase exactly?
I don't really expect more than order or 200 commands - about 8 dwords.
And the operation we normally need is checking whether a given command
is supported, with a list that will be a slow lookup.

Besides with your idea driver first needs to check how many commands
are supported, then do the query - two roundtrips to device.
With the proposed interface, driver just allocates a buffer
for commands it knows about. Device truncates the buffer
to the length supplied by driver, so any commands outside
the buffer are ignored.

-- 
MST

