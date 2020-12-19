Return-Path: virtio-comment-return-1573-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Sat, 19 Dec 2020 14:05:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201218155526-mutt-send-email-mst@kernel.org>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201216155218.GA720702@stefanha-x1.localdomain>
 <b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
 <20201217030015-mutt-send-email-mst@kernel.org>
 <20201217102640.GG4338@stefanha-x1.localdomain>
 <1ccc5889-4e28-deac-8168-c6f0665231c1@intel.com>
MIME-Version: 1.0
In-Reply-To: <1ccc5889-4e28-deac-8168-c6f0665231c1@intel.com>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Dec 18, 2020 at 10:06:45AM +0800, Jie Deng wrote:
> 
> On 2020/12/17 18:26, Stefan Hajnoczi wrote:
> > On Thu, Dec 17, 2020 at 03:00:55AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Dec 17, 2020 at 03:08:07PM +0800, Jie Deng wrote:
> > > > 
> > > >          +The \field{flags} of the request is currently reserved as zero for future
> > > >          +feature extensibility.
> > > >          +
> > > >          +The \field{written} of the request is the number of data bytes in the \field{write_buf}
> > > >          +being written to the I2C slave address.
> > > > 
> > > >      This field seems redundant since the device can determine the size of
> > > >      write_buf implicitly from the total out buffer size. virtio-blk takes
> > > >      this approach.
> > > > 
> > > > The read/write are the actual number of data bytes being read from or written
> > > > to the device
> > > > which is not determined by the device. So I don't think it is redundant.
> > > I am still not sure I understand the difference.
> > > This point is unclear to multiple people.
> > I think I get it now. This is made clear by splitting the struct:
> > 
> >    /* Driver->device fields */
> >    struct virtio_i2c_out_hdr
> >    {
> >        le16 addr;
> >        le16 padding;
> >        le32 flags;
> >    };
> > 
> >    /* Device->driver fields */
> >    struct virtio_i2c_in_hdr
> >    {
> >        le16 written;
> >        le16 read;
> >        u8 status;
> >    };
> 
> written/read are not device->driver fields. They are driver->device fields.
> They are not determined by the device but the driver(user).
> 
> However, Michael said that the two fields may duplicate buf size available
> in the descriptor. He intended to remove them.
> 
> "
> I note that read and written actually duplicate buf size
> available in the descriptor.
> Given we no longer mirror i2c_msg 1:1 do we still want to do this?
> It will be trivial for the host device to populate these fields
> correctly for linux.
> Duplication of information iten leads to errors ...
> "
> 
> But there is a corner case I'm not sure if you have noticed.
> 
> read and written can be 0. I think we may not put a buf with size 0 into the
> virtqueue.

You always have the header and the status, right?
E.g. with the below, the total buffer size is virtio_i2c_out_hdr size +
write size for writes and read size + virtio_i2c_in_hdr size for reads.
Neither result is ever 0.

> @Stefan @Paolo
> 
> So what's your opinion about these two fields ?
> 
> >    /*
> >     * Virtqueue element layout looks like this:
> >     *
> >     * struct virtio_i2c_out_hdr out_hdr; /* OUT */
> >     * u8 write_buf[]; /* OUT */
> >     * u8 read_buf[]; /* IN */
> >     * struct virtio_i2c_in_hdr in_hdr; /* IN */
> >     */
> > 
> > This makes sense to me: a bi-directional request has both write_buf[]
> > and read_buf[] so the vring used.len field is not enough to report back
> > how many bytes were written and read. The virtio_i2c_in_hdr fields are
> > really needed.
> > 
> > Please split the struct in the spec so it's clear how this works.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

