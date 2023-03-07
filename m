Return-Path: <virtio-dev-return-11474-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63947C678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:54:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C34E567045
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:54:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE4EA9866CF
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 10:54:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B0B019866C3; Tue,  7 Mar 2023 10:54:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 999429866C2;
	Tue,  7 Mar 2023 10:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGhW5zgH+bXGaE1/rOak6kUYbi2B7T/Mwjl7ioWj0pSfjmBXcEPmDNT7SzxD9Sjb/4pEKvdvfeqomNTznKFEmkQ7SkeiB11TDTC30vfUNop1BnW5+HDp4a5H5s0NvEkxdvhQolGaPZZJabuBzF1FKJ92Fw0iro9lP86E1xBhVi/NdJ/QqRU0v0HaumADzIuKxJ61lrbEI77OgJaI/YZ7+v8WeYJb66O/CsNU0dPGuS7T0MSrVcZwGDB64CHwIl7BEvWDt3DCSN/dWeN/l4X0zmEKapih75FCo1OlTLeKYJx28/P8CL949LZqg3wvGxjVepg/pLT8EappyHcnKjHzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9Wn3X4WYggq+9An739WoKwEpLYnWUcc42nLyfk6DqA=;
 b=a4cc7XQNQ8v4p+W5//UuoND6qL+DgwXdKNN7Z/mwdtcMNYNZhjl27J86u5PP1Nkhul+5evSQk2oW0qEXRz9uf9eEQkmjDftAMmWHyDsyhmI2A4B3KAJrIvuHQuQkpgM+3uvHs5C0Jek4tB1OgjYO4P+vLYDdDHd9kKZRh8bfMO7IRIX5l9ZS7+VZ6VT7Zo1EX+L3NgjyCaS/teSNFT0yN3TkKwvZewjC5v4P89Ou5MtsucUPJUhZYCCGo/sHCji+BwqiLPDvdY2W54waxT/fgnx1DmmZQMyKWQ11BUXpOm/XPORbJ+ccu/BBkqpZi5pLb1H8eopvmmtCm7AxB8qhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com,
        cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
        nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
        pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
        Parav Pandit
 <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
References: <cover.1677761896.git.mst@redhat.com>
 <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
Date: Tue, 07 Mar 2023 10:54:15 +0000
Message-ID: <m2cz5kzvag.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::15) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CH2PR10MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 44eb59ae-1850-4414-75fe-08db1efa4e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e8tFgHKmDVSfZ8jS14lKuhhcxsnrNIqpB0JhmD1fZzRcMN4KhQOsXQSR5kuf4i8e5Pyh5aQdAkiLPLyOR4qnC3X5xaGbekjxyr0itl7nV6KZlnnaQyFqBHYvDtK/eRIdd6sXQ+9vfkb9RHwNlE5wrjZCEUSQsOWfnn1aKlYBFTLGfeLqZRXkFDm05vmhSig3oRyP9Ng9u4QzyVm9QYiPE2dz8w10oNKYWs4gsXVdkkB3ieoki3ZD3VXijwFsIwMMOwra3SwAWEzPX+uMO/z3/zHgH1sHw7KdVoSRhL2Ndv7j1XA7EFtCiGomlFb6wsYfyQLSOjWFvPVq4m7s8e3Q7S7zn0y0DpAGNZ+HsgUUT29y9wIFqoGYHSFxarRMgNFROXCzPCzQLyNxPHEjezOMpeE2cL45DCeDaaTBdOADPaWqkYfExrJ4iZkowiRlJSlbPg1+/DPzfZ1iG9qAyBhd7WdqO559Q55UMxzbvfmmyHYtBvEInfJtjpkjI8sXq8ROOrCmRQpmQDlouR8oJwuqhPQrDAORaAWlmKWx5EtiE2cmk9N7ZpSZd/bJ3gISQ0vtnI+XCVAK3miKt4KRj2QZHsdnTDFsGcownh7nJzMsMx9GORE5W105SJEY00Wn5/5sI7UBXMRGf4CTkqzqeQjMw1NwxO57zEr7rmlU/B33NoSUZDCDpCt5lL0SaMGxHasL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(478600001)(5660300002)(7416002)(86362001)(36756003)(186003)(26005)(6486002)(6512007)(6506007)(2906002)(2616005)(44832011)(66556008)(66476007)(66946007)(4326008)(8676002)(38100700002)(66899018)(6666004)(83380400001)(8936002)(316002)(921005)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9I5LwNDJVp2V4WlmKOe58H//M/oL1m4z5xMWbeefvjTLY1/VrtLYuUdLN6v0?=
 =?us-ascii?Q?FcH4GAVY/atCNG0Pb9f2qtMYYut4ck/+yf8LdXAI1aWKzh2zBx9r+eCACFY3?=
 =?us-ascii?Q?Rhz7H915z5242xFn1jH/V4JextWcvzGVvsVrra5tb+QFTpnrBHkI+uSds7vI?=
 =?us-ascii?Q?hihjGqpKUvTeREEb3r4p4UD+LYHvAJQ3SqNav4NcOw9ouk25J1xGQFjN4B2v?=
 =?us-ascii?Q?kd9GNs3RWI+DVteLxYvmW8863nKjZayeLk2g/WvMqr5zv/Ng4Dl1/VmQPCPJ?=
 =?us-ascii?Q?OVDHrB1NQdifGfBUkal0DN69qWztvh5mkrfuBRBrY4LfIngROJ1Ypeluz9+n?=
 =?us-ascii?Q?9TRXGEylNhbBMEPX6V+BG0VHGpwkox3sS9aWK+YxK+rFJUaI+2sQR5vRboe9?=
 =?us-ascii?Q?elnxk5CBIdRdqqlqw6ibj4WlDmbMIwkJ+km5OVHDEobe4uzBCxpbUJq/55hy?=
 =?us-ascii?Q?3iKqjh80CqQlsLPSM3qQFcClQCXfhiWcvMf8fUFDSlAbUtMeEdsp60qDqAEl?=
 =?us-ascii?Q?aQ1drNM1HzN80pI86bY/Sk9MRh45PHtdJ3gujO/sRBs1rsnapUDhVq2Hl+pV?=
 =?us-ascii?Q?0JsRDeAtzT77bNCAIjoniZmzwhJuaXt2SqUaLmTKPzqRYwQD4OTF9tuCpqEI?=
 =?us-ascii?Q?9RbFtpjO9TGnNixeaJVM4u8eVja7w6LJbQrvf2LD34pEI7z7Y8W50ovkf4Eh?=
 =?us-ascii?Q?3glEpqtgJuL6eTl2dPBYnaqRVGRrJ5fEJBPt/S03MkX3UFREKZznrC6u4OnU?=
 =?us-ascii?Q?FQUGwvuF042zWnbE0IbsXLCet/x78iDNYbH2hIsXPmBX1+JoZ68MvQpqR++v?=
 =?us-ascii?Q?EI8nfyNPzWEbZcdLPH4q/uCLlFV2Uh+L6ii+d9EiepTkyDYKjXjfQrhVGZ+9?=
 =?us-ascii?Q?flZJMdapiz724LqvIb2yb0g3Bsg+FxQLbh9QdFokb1u0BeWaOOublDO6Mq0U?=
 =?us-ascii?Q?CgwTE9LvjvNVXlV44lFyVBWWesmIK2BTLzn4re2QDUfoUGMKNwoDLI6HVofr?=
 =?us-ascii?Q?n81hP+n/HYJkVtNPPW9CQHFQccTqqa0iwH3E1cRd7EuMp2IVLfP5h9Do5SPp?=
 =?us-ascii?Q?EWa8a6ONvW21R0Hd3YIg6WOyIP86vjLM6SqFfteaRn+ADHq+UmgJsBQyYIaI?=
 =?us-ascii?Q?dhFBaNsKTItx7kS6V9WctdUYbp1tSBsFgTsSiGX5bmjPSMBvORbCmt4DfQQh?=
 =?us-ascii?Q?OSrvh2rz0MI2dGUMySUP2Blzan0SDax1Cus1mR3Pi7UCY9d9cGSxiqzXz7nR?=
 =?us-ascii?Q?kMUYb9lDvoDtyLJjtuWEYEgY6D8x26UMUorVaqVKt1nN51vdorTComIuppXd?=
 =?us-ascii?Q?+MLHt5MAai/c3HjIBQjH8EbXyNLfmaqhCF4uEssu1XGrlG1B42Rf1iZHRsrH?=
 =?us-ascii?Q?ZyT1tXnKslqG+wWiRs1LpDETcZ0xkX0Y5LKY4T0oNda0S8V3rWw8W6TZLy7H?=
 =?us-ascii?Q?MxghJ08z4NyPgjiuT1uaeAYul3O8FKwvWbD/WkwIMHSHezURvPKJpJ86OZ9F?=
 =?us-ascii?Q?/GRr0qRHIqr8hFE0PEmO/OrAqW9cx6c/Ds3qTZFUhHEOWhGjK/IACCOVAHch?=
 =?us-ascii?Q?VExG0ZK6WnxYQ4ePQDVficz1DYmVA2r3u6VoQh6iy0pWt6CvJR8qlqbvezkL?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7/NU0zPTo7RX5X270ClYgYaSlDuy+neG5xxYtzC8+PwWNEtvSPm8JTzPxr5Ym+j8UqQj5m9m8qLUsW0wO5ZBgdgqLMj6A//qCZd36l4sljhMThoEQ59YsQob2nHDYnXEf/w6wQFhfowxmBukbiS9mXBEh6GG3XU/36AdPjP1ETJu492EXZZ6se2TTxlzkRqs6g74dgzxvuGYBq5nXIUp/SBp9Qsae54fBJ7KJI3jqCEItMRfdAV8pVx1CA0xUWSJXUbbMgjSkd/CEQtt63dCzFjNYqSP3xNAswTIBf84WoyzbhRoDXb/zuWFBGHJFMI35XrOlf5IiZJappunrHRf7Cic9vYEcDhDTJBBJ+WQkNIKVy6GQW7kZ5KNHscPDz8+Bk55fPbA7OyYaVCfYvxfTjHt0ynFlGSfBJ8NiT2AU2x9CUT+kCQSknNTkuXzG3s8ZM8c3vLl/bej7cDTkhqlhGXv1v4SgP/TH4/D+fd6i5v7mSVB2Wqbt2guDrdLV7s360/KDowaK4JBQ/lN5cYUKlqn+QhaiY9etvzWFyqmXsbApgx4W/+oXHBCt5VPrprmAZc0DTd0WH1pZREed274rra0Erc1zssEBB0f/2CqIiBG0CvJmXdg+R+OAnkF8SjaU73rO1iwzW9dkV8Yx2Ipl52i2+tVIrWACFlJ7byqu1g5I3VgrnIN7iJLWMSaAtvXqHweXCOGay7q/jJ0VzLN7tz5RyGPJRpuOx2C1ro2iKMz081vCfbUKV4UufcrW3l9nbkcEpX7CcP76uMT+074KBmh1mZA7jvs0KfsIxBTTafkpwT0e76TCa9c9VfRqZDRorG0dRy3Sn13XMY3Ot5ECLmbkH2my3qcH1ABE4xiidU/C2Cpuk2/d7rka24eS5UBSexLsIFFcHX3rk5YACGArQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44eb59ae-1850-4414-75fe-08db1efa4e4f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 10:54:21.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4P16mjQV44oN+1FB33dIU5sID1bDQ+SgtvqcJlpAgTPtzvEtCJptw2aRZYJBx94I1YVlJrwf0lxVBEGfjmW8m/lI1MqIljEdqhLYl9Oc2S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_04,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070097
X-Proofpoint-GUID: GOXiVj6it8hdUP-520lbUIS0iuTwYTCn
X-Proofpoint-ORIG-GUID: GOXiVj6it8hdUP-520lbUIS0iuTwYTCn
Subject: Re: [virtio-dev] [PATCH v10 08/10] admin: command list discovery

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Add commands to find out which commands does each group support,
> as well as enable their use by driver.
> This will be especially useful once we have multiple group types.
>
> An alternative is per-type VQs. This is possible but will
> require more per-transport work. Discovery through the vq
> helps keep things contained.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/admin.tex b/admin.tex
> index 3ffac2e..1172054 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -99,7 +99,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  \hline
>  opcode & Name & Command Description \\
>  \hline \hline
> -0x0000 - 0x7FFF & - &  Group administration commands    \\
> +0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
> +0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
> +0x0002 - 0x7FFF & - &  Group administration commands    \\
>  \hline
>  0x8000 - 0xFFFF & - & Reserved    \\
>  \hline
> @@ -156,6 +158,99 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  depends on these structures and is described separately or is
>  implicit in the structure description.
>  
> +Before sending any administration commands to the device, the driver
> +needs to communicate to the device which commands it is going to
> +use. Initially (after reset), only two commands are assumed to be used:
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Before sending any other commands for any member of a specific group to
> +the device, the driver queries the supported commands via
> +VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it will use via
> +VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
> +VIRTIO_ADMIN_CMD_LIST_USE
> +both use the following structure describing the
> +command opcodes:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_list {
> +       /* Indicates which of the below fields were returned
> +       le64 device_admin_cmds[];
> +};
> +\end{lstlisting}
> +
> +This structure is an array of 64 bit values in little-endian byte
> +order, in which a bit is set if the specific command opcode
> +is supported. Thus, \field{device_admin_cmds[0]} refers to the first 32-bit value

64-bit.

> +in this array corresponding to opcodes 0 to 63,
> +\field{device_admin_cmds[1]} is the second 64-bit value
> +corresponding to opcodes 64 to 127, etc.
> +For example, the array of size 2 including
> +the values 0x3 in \field{device_admin_cmds[0]}
> +and 0x1 in \field{device_admin_cmds[1]} indicates that only
> +opcodes 0, 1 and 64 are supported.
> +The length of the array depends on the supported opcodes - it is
> +large enough to include bits set for all supported opcodes,
> +that is the length can be calculated by starting with the largest
> +supported opcode adding one, dividing by 64 and rounding up.
> +In other words, for
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE the
> +length of \field{command_specific_result} and
> +\field{command_specific_data} respectively will be
> +$DIV_ROUND_UP(max_cmd, 64) * 8$ where DIV_ROUND_UP is integer division
> +with round up and \field{max_cmd} is the largest available command opcode.
> +
> +The array is also allowed to be larger and to additionally
> +include an arbitrary number of all-zero entries.
> +
> +Accordingly, bits 0 and 1 corresponding to opcode 0
> +(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
> +(VIRTIO_ADMIN_CMD_LIST_USE) are
> +always set in \field{device_admin_cmds[0]} returned by VIRTIO_ADMIN_CMD_LIST_QUERY.
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +This command has no command specific data.
> +The device, upon success, returns a result in
> +\field{command_specific_result} in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of administration commands supported for the given group.
> +
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
> +is set to 0x1.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +The \field{command_specific_data} is in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of administration commands used by the driver.
> +This command has no command specific result.
> +
> +The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
> +query the list of commands valid for this group and before sending
> +any commands for any member of a group.
> +
> +The driver then enables use of some of the opcodes by sending to
> +the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
> +of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
> +both understood and used by the driver.
> +
> +If the device supports the command list used by the driver, the
> +device completes the command with status VIRTIO_ADMIN_STATUS_OK.
> +If the device does not support the command list, the device
> +completes the command with status
> +VIRTIO_ADMIN_STATUS_INVALID_FIELD.
> +
> +Note: drivers are assumed not to set bits in device_admin_cmds
> +if they are not familiar with how the command opcode
> +is used, since devices could have dependencies between
> +command opcodes.
> +
> +It is assumed that all members in a group support and are used
> +with the same list of commands. However, for owner devices
> +supporting multiple group types, the list of supported commands
> +might differ between different group types.
> +
>  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>  
>  An administration virtqueue of an owner device is used to submit
> -- 
> MST
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
-- 
If I could buy my reasoning, I'd pay to lose.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

