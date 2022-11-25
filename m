Return-Path: <mst@redhat.com>
Date: Fri, 25 Nov 2022 06:56:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9 09/10] admin: conformance clauses
Message-ID: <20221125065543-mutt-send-email-mst@kernel.org>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-10-mst@redhat.com>
 <CACGkMEsDi3+iU3QjQ4Mqp5yQc0epOqLZXnYTnqaoPwtB6pvF7A@mail.gmail.com>
 <20221124033204-mutt-send-email-mst@kernel.org>
 <7d27538d-f185-c1fe-b19d-716930fd3f08@redhat.com>
 <87tu2ngt0g.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87tu2ngt0g.fsf@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 25, 2022 at 12:42:23PM +0100, Cornelia Huck wrote:
> On Fri, Nov 25 2022, Jason Wang <jasowang@redhat.com> wrote:
> 
> > 在 2022/11/24 16:36, Michael S. Tsirkin 写道:
> >> On Thu, Nov 24, 2022 at 02:51:21PM +0800, Jason Wang wrote:
> >>> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>> +The device MUST NOT fail a command solely because the buffers
> >>>> +provided are shorter or longer than described in this
> >>>> +specification.
> >>> I may miss something but how can it work if the buffer is shorter?
> >> driver does not care what's there.
> >>
> >> this is mostly for forward compatibility - we'll add more fields and
> >> I don't want to explain separately that old drivers post
> >> short buffers with less fields.
> >
> >
> > For example:
> >
> > The patch said:
> >
> > struct virtio_admin_cmd_list {
> >         /* Indicates which of the below fields were returned
> >         le32 device_admin_cmds[];
> > };
> >
> > Does it mean the query can still succeed even if there's no space for 
> > virtio_admin_cmd_list in the writable buffer?
> 
> Can we pick an absolute minimum length? All drivers need to be able to
> at least accommodate this one. Or is it ok for the driver to send a
> completely useless query that doesn't get any data back?

I think it might be a way to check that a group exists.

-- 
MST

