Return-Path: virtio-comment-return-1477-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <5d3d8a27893734be954ebbe560f638fbafb3429c.1603778046.git.jie.deng@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0a25b9d-c1e7-21e8-0944-9fa5796adfca@redhat.com>
Date: Wed, 28 Oct 2020 21:10:20 +0100
MIME-Version: 1.0
In-Reply-To: <5d3d8a27893734be954ebbe560f638fbafb3429c.1603778046.git.jie.deng@intel.com>
Subject: Re: [virtio-comment] [PATCH v3] virtio-i2c: add the device
 specification
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Jie Deng <jie.deng@intel.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 27/10/20 07:00, Jie Deng wrote:
> +The driver queues requests to the virtqueue, and they are used by the
> +device. The request is the representation of one segment of an I2C
> +transaction. Each request is of form:
> +
> +\begin{lstlisting}
> +struct virtio_i2c_req {
> +        le16 addr;
> +        le16 flags;
> +        le16 len;
> +        u8 buf[];
> +        u8 status;
> +};
> +\end{lstlisting}

Hi,

one extremely common two-segment I2C transaction is not reproducible
with virtio-i2c.  This is when a write is followed by a read: the master
starts off the transmission with a write, then sends a second START,
then continues with a read from the same address.

Would it make sense to define the request like

struct virtio_i2c_req {
=09le16 addr;
=09le16 written;
=09le16 read;
=09u8 bufwrite[];
=09u8 status;
=09u8 bufread[];
};

instead?

Thanks,

Paolo


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

