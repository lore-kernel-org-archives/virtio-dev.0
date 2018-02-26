Return-Path: virtio-return-2914-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1519633014-8683-1-git-send-email-changpeng.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e264f4f4-ee96-e77a-54c9-a4f07b996359@redhat.com>
Date: Mon, 26 Feb 2018 16:20:39 +0100
MIME-Version: 1.0
In-Reply-To: <1519633014-8683-1-git-send-email-changpeng.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [virtio] Re: [RFC] virtio-blk: add discard and write zeroes features to
 specification
To: Changpeng Liu <changpeng.liu@intel.com>, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
Cc: cavery@redhat.com, stefanha@redhat.com, pawelx.wodkowski@intel.com, james.r.harris@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 26/02/2018 09:16, Changpeng Liu wrote:
> Existing virtio-blk protocol doesn't have DISCARD/WRITE ZEROES support,
> this will impact the performance when using SSD backend over file systems.
> 
> Here is the proposal to extend existing virtio-blk protocol to support
> DISCARD/WRITE ZEROES commands.
> 
> Basic idea here is using 16 Bytes payload to support 1 descriptor, users
> can put several segments together with 1 DISCARD command.
> 
> struct virtio_blk_discard_write_zeroes {
>        le64 slba;
>        le32 nlba;
>        struct {
>                le32 unmap:1;
>                le32 reserved:31;
>        } flags;
> };
> 
> For the purpose to support such feature, we need to introduce 2 new feature
> flags: VIRTIO_BLK_F_DISCARD/VIRTIO_BLK_F_WRITE_ZEROES, and 2 new command
> types: VIRTIO_BLK_T_DISCARD/VIRTIO_BLK_T_WRITE_ZEROES. Also we introduce
> 3 new parameters in the configuration space of virtio-blk: max_discard_sectors/
> max_discard_seg/max_write_zeroes_sectors. These parameters will tell the
> OS what's the granularity when issuing such commands.
> 
> If both DISCARD and WRITE ZEROES are supported, unmap flag bit maybe used
> for WRITE ZEROES command with DISCARD bit enabled.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  content.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index c7ef7fd..5555b18 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4127,6 +4127,13 @@ device except where noted.
>  
>  \item[VIRTIO_BLK_F_CONFIG_WCE (11)] Device can toggle its cache between writeback
>      and writethrough modes.
> +
> +\item[VIRTIO_BLK_F_DISCARD (13)] Device can support discard command, maximum
> +    discard sectors size in \field{max_discard_sectors} and maximum discard
> +    segment number in field{max_discard_seg}.
> +
> +\item[VIRTIO_BLK_F_WRITE_ZEROES (14)] Device can support write zeroes command,
> +	maximum write zeroes sectors size in \field{max_write_zeroes_sectors}.
>  \end{description}
>  
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
> @@ -4170,6 +4177,9 @@ struct virtio_blk_config {
>                  le32 opt_io_size;
>          } topology;
>          u8 writeback;

Let's add three padding bytes here, for clarity.  Please add a note that
these three bytes MUST be zero in the "Device Requirements: Device
Initialization" section.

> +        le32 max_discard_sectors;
> +        le32 max_discard_seg;

Perhaps add here:

	le32 discard_sector_alignment;

(and document it below)?

> +        le32 max_write_zeroes_sectors;

Perhaps we can put a bit here saying whether write_zeroes will ever look
at the \field{unmap} bit?  Like:

	u8   write_zeroes_may_unmap;

>  };
>  \end{lstlisting}
>  
> @@ -4211,6 +4221,15 @@ according to the native endian of the guest rather than
>    after reset can be either writeback or writethrough.  The actual
>    mode can be determined by reading \field{writeback} after feature
>    negotiation.
> +
> +\item If the VIRTIO_BLK_F_DISCARD feature is negotiated,
> +    \field{max_discard_sectors} and \field{max_discard_seg} can be read
> +    to determine the maximum discard sectors and maximum number of discard
> +    segments for the block driver to use.
> +
> +\item if the VIRTIO_BLK_F_WRITE_ZEROES feature is negotiated,
> +    \field{max_write_zeroes_sectors} can be read to determine the maximum
> +    write zeroes sectors for the block driver to use.

So only one struct virtio_blk_discard_write_zeroes is possible?

>  \end{enumerate}
>  
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
> @@ -4270,21 +4289,41 @@ struct virtio_blk_req {
>          u8 data[][512];
>          u8 status;
>  };
> +
> +struct virtio_blk_discard_write_zeroes {
> +       le64 slba;
> +       le32 nlba;

	le64 sector;
	le32 num_sectors;

please (more consistent with the rest).

> +       struct {
> +               le32 unmap:1;
> +               le32 reserved:31;
> +       } flags;
> +};
>  \end{lstlisting}
>  
>  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
> -(VIRTIO_BLK_T_OUT), or a flush (VIRTIO_BLK_T_FLUSH).
> +(VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
> +(VIRTIO_BLK_T_WRITE_ZEROES) or a flush (VIRTIO_BLK_T_FLUSH).
>  
>  \begin{lstlisting}
>  #define VIRTIO_BLK_T_IN           0
>  #define VIRTIO_BLK_T_OUT          1
>  #define VIRTIO_BLK_T_FLUSH        4
> +#define VIRTIO_BLK_T_DISCARD      16
> +#define VIRTIO_BLK_T_WRITE_ZEROES 32
>  \end{lstlisting}

Bit 0 defines the command direction, which should be 1, while the
command number is in bits 1-30.  Since the highest-numbered command is
currently 8, we can use 11 and 13 respectively for discard and write zeroes.

>  The \field{sector} number indicates the offset (multiplied by 512) where
>  the read or write is to occur. This field is unused and set to 0
>  for scsi packet commands and for flush commands.
>  
> +The \field{data} used for discard or write zeroes command can be
> +described by structure virtio_blk_discard_write_zeroes, while here,
> +\field{sector} is not used for the two commands. \field{slba} indicates
> +the starting sector of the segment, \field{nlba} indicates the number
> +of sectors for discard/write zeroes commands, \field{unmap} only used
> +for write zeroes command, which means write zeroes to specified sectors
> +while keep these sectors discarded.

-----
The \field{sector} number indicates the offset (multiplied by 512) where
the read or write is to occur. This field is unused and set to 0
commands other than read or write.

The \field{data} used for discard or write zeroes command is
described by one or more virtio_blk_discard_write_zeroes structs.
\field{sector} indicates the starting sector of the segment, while
\field{nlba} indicates the number of sectors in each discarded range.
\field{unmap} is only used for write zeroes command.
-----

Please add the following to "Device Requirements: Device Operation":

-----
The device MUST set the \emph{status} byte to VIRTIO_BLK_S_UNSUPP for
discard and write zeroes commands if any unknown flag is set.
Furthermore, the device MUST set the \emph{status} byte to
VIRTIO_BLK_S_UNSUPP for discard commands if the \field{unmap} flag is set.

For discard commands, the device MAY deallocate the specified range of
sectors in the device backend storage.

For write zeroes commands, if the \field{unmap} is set, the device MAY
deallocate the specified range of sectors in the device backend storage,
as if the DISCARD command had been sent.  After a write zeroes command
is completed, reads of the specified ranges of sectors MUST return
zeroes.  This is true independent of whether \field{unmap} was set or clear.
-----

Please add this to "Device Requirements: Driver Operation", too:

-----
The \field{unmap} bit MUST be zero for discard commands.  The driver
MUST NOT assume anything about the data returned by read requests after
a range of sectors has been discarded.
-----

If we added the "write_zeroes_may_unmap" bit, something like this would
go in "Device Requirements: Device Operation":

----
The device SHOULD clear the \field{write_zeroes_may_unmap} field of the
virtio configuration space if and only if a write zeroes request cannot
result in deallocating one or more sectors.  The device MAY change the
content of the field during operation of the device; when this happens,
the device SHOULD trigger a configuration change interrupt.
-----

Thanks,

Paolo

>  The final \field{status} byte is written by the device: either
>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
> 


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

