Return-Path: virtio-comment-return-1471-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Jie Deng <jie.deng@intel.com>
References: <61930337391bdfd23ed164288d998c04177bc839.1603435652.git.jie.deng@intel.com>
 <20201023115932-mutt-send-email-mst@kernel.org>
 <a4a8ee83-d3e6-df1f-c0ac-f608d563522e@intel.com>
Message-ID: <84f7c46c-830d-d809-e8ec-42703be54256@intel.com>
Date: Mon, 26 Oct 2020 16:08:05 +0800
MIME-Version: 1.0
In-Reply-To: <a4a8ee83-d3e6-df1f-c0ac-f608d563522e@intel.com>
Subject: [virtio-comment] Re: [PATCH v2] virtio-i2c: add the device specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2020/10/26 9:22, Jie Deng wrote:

> On 2020/10/24 0:00, Michael S. Tsirkin wrote:
>
>> On Fri, Oct 23, 2020 at 02:51:25PM +0800, Jie Deng wrote:
>>> +
>>> +The driver queues requests to the virtqueues, and they are used by the
>>> +device. The request is the representation of one segment of an I2C
>>> +transaction. Each request is of form:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_i2c_req {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 addr;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 flags;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 le16 len;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 buf[];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 status;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +The \field{addr} is the address of the I2C slave device.
>>> +
>>> +The first bit of \field{flags} indicates whether it is a read or=20
>>> write request.
>>> +It means a read request if the first bit of \field{flags} is set,=20
>>> otherwise
>>> +it is a write request. The rest bits of \field{flags} are reserved.
>>>
>>
>> So how does one creates a multi-segment transaction then?
>>
> The I2C doesn't support segments numbering and sorting.
> So if one creates a multi-segment transaction, then he/she should keep=20
> the segments in order.
>
> Thanks.
>
What about adding following requirement to the spec ?

"A driver MUST keep the requests in order if a multi-segment transaction=20
is going to be sent."
"A device MUST guarantee the requests being handled in order if a=20
multi-segment transaction is received."

Thanks.


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

