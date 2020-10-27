Return-Path: virtio-comment-return-1473-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 27 Oct 2020 07:20:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201027071957-mutt-send-email-mst@kernel.org>
References: <61930337391bdfd23ed164288d998c04177bc839.1603435652.git.jie.deng@intel.com>
 <20201023115932-mutt-send-email-mst@kernel.org>
 <a4a8ee83-d3e6-df1f-c0ac-f608d563522e@intel.com>
MIME-Version: 1.0
In-Reply-To: <a4a8ee83-d3e6-df1f-c0ac-f608d563522e@intel.com>
Subject: [virtio-comment] Re: [virtio-dev] Re: [PATCH v2] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 26, 2020 at 09:22:07AM +0800, Jie Deng wrote:
> On 2020/10/24 0:00, Michael S. Tsirkin wrote:
> 
> > On Fri, Oct 23, 2020 at 02:51:25PM +0800, Jie Deng wrote:
> > > +
> > > +The driver queues requests to the virtqueues, and they are used by the
> > > +device. The request is the representation of one segment of an I2C
> > > +transaction. Each request is of form:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_i2c_req {
> > > +        le16 addr;
> > > +        le16 flags;
> > > +        le16 len;
> > > +        u8 buf[];
> > > +        u8 status;
> > > +};
> > > +\end{lstlisting}
> > > +
> > > +The \field{addr} is the address of the I2C slave device.
> > > +
> > > +The first bit of \field{flags} indicates whether it is a read or write request.
> > > +It means a read request if the first bit of \field{flags} is set, otherwise
> > > +it is a write request. The rest bits of \field{flags} are reserved.
> > > 
> > 
> > So how does one creates a multi-segment transaction then?
> > 
> The I2C doesn't support segments numbering and sorting.
> So if one creates a multi-segment transaction, then he/she should keep the
> segments in order.
> 
> Thanks.

Fine, but I see no flags to signal start/end of such a transaction.

> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 


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

