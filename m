Return-Path: virtio-comment-return-1463-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <7e62cac21047d1692edea06c1fd917faea53087f.1600742717.git.jie.deng@intel.com>
 <20201021080250-mutt-send-email-mst@kernel.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <0525fa7b-fdb4-fb8d-dac7-7aad143fc380@intel.com>
Date: Thu, 22 Oct 2020 15:45:16 +0800
MIME-Version: 1.0
In-Reply-To: <20201021080250-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH] virtio-i2c: add the device specification
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 2020/10/21 20:08, Michael S. Tsirkin wrote:

> On Tue, Sep 22, 2020 at 10:49:02AM +0800, Jie Deng wrote:
>
> +
> +The first bit of \field{flags} indicates whether it is a read or write r=
equest.
> +It mesns a read request if the first bit of \field{flags} is set, otherw=
ise
>
> means

I will fix this typo. Thank you.

>> +it is a write request. The rest bits of \field{flags} are reserved.
> Do we really need this flg? write request is just a big write followed by=
 1
> byte read, read request is write read 1 byte read.
The "addr", "flags", "len" and "buf" are all from Linux kernel structure=20
"struct i2c_msg".
This design may help the backend driver to extract "struct i2c_msg" from
"struct virtio_i2c_req" easily.

The "flags" has many bits been defined in I2C. It is no mere an=20
identification for
read/write. Although, currently, we only used the first bit, we may use=20
other bits
for feature extension in the future. So I think it's necessary to keep it.

Thanks.


>
>
>> +The \field{len} of the request indicates the length of the I2C message.
>> +
>> +The \field{buf} of the request contains the I2C message. If the first b=
it of
>> +\field{flags} is '1', the \field{buf} is written by the device and it c=
ontains
>> +the message read from the device. If the first bit of \field{flags} is =
'0', the
>> +\field{buf} is written by the driver and it contains the message writte=
n to the
>> +the device.
>> +
>> +The final \field{status} byte is written by the device: either VIRTIO_I=
2C_MSG_OK
>> +for success or VIRTIO_I2C_MSG_ERR for error.
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_I2C_MSG_OK     0
>> +#define VIRTIO_I2C_MSG_ERR    1
>> +\end{lstlisting}
>> +
>> +\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C A=
dapter Device / Device Operation}
>> +
>> +A driver MUST set \field{addr}, \field{flags} and \field{len} before se=
nding
>> +the message.
>> +
>> +A driver MUST place the I2C message into \field{buf} if the first bit o=
f
>> +\field{flags} is '0'.
>> +
>> +A driver MUST NOT use the message if the final \field{status}
>
> What does "use the message" mean? What message?
I mean=C2=A0 the "addr", "flags" , "len " and "buf " in "virtio_i2c_req" he=
re.
I will describe it more precisely in v2.

Thanks.

>> return from the
>> +device is VIRTIO_I2C_MSG_ERR.
> returned?

I will fix this typo. Thank you.


>> +
>> +\devicenormative{\subsubsection}{Device Operation}{Device Types / I2C A=
dapter Device / Device Operation}
>> +
>> +A device MUST NOT change the value of \field{addr}, \field{flags} and \=
field{len}.
>
>
>> +
>> +A device MUST place the message into \field{buf} if the first bit of \f=
ield{flags}
>> +is '1'.
>
> again, what the message?
>
Here is the I2C message. I will describe it more precisely in v2.

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

