Return-Path: <virtio-dev-return-13585-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8A5C6FA8F
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 10:58:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE94812D343
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 10:58:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C8BE4986526
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 10:58:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BBF909863E1; Tue, 29 Aug 2023 10:58:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB37E9863D6;
	Tue, 29 Aug 2023 10:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCeo5EEXsn3AoysPjhC4gy4k+p8Kya8fu7oTXMLqYCmU/r/8SUftCWLH/bBmoB3eXbpLi0XqGZlm+7/tj9avbzLNuZgB1FF8VqDClL4oIZYROKNgGIizlUhZ0tD0s+m9p3d/vEGX6Tlr/gf9ZMjcxx+4q4gmvlU1sxe0X/3X8RCDWSE1FJyMFFrPngRVBmj4U5/CCgLbDJMTbmJrTvIva5XlizsEbSb/mCzhop8EcFpRc2xy5dX9YjfR0APIB6KZGyfKNikVGXV8We6PvlhdZ+KoNnoEfPQCN8B83Ix37/eaFzQM/ZASp1qhzwrXkrB8uTbSkbr4vQazkZSvbam7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf3hq7tLjbGCzLhDvE6HYP/YhYHWUIoQM9XptGYobzY=;
 b=CbP15Yl+B0zHW8FTj2guJul0w09XzkCRjsjgFMvYRj8kGuoIo7twobuQh3XMMXTDqhBq5wiaY0ln5vE0ibYrajSl9RzpZvexeWL+f/RMu5U0yEaXvhXnWFuSlIMZS45q3EGFrbTGaEMx/waxaigpoXG3qNGGt3PhvpZ0u1bLONYTbO/9eNQhnvqxDW+efNyMQVw0xsj3Sax+akppZWXzM+v+/FEH12u+HZNh0E9fhKxo+IU2KHfyeurUw2ZnG6GJ9Nya9PKHzbuQNp7EnrJ9P+9D0n5cs6BCIw5HaPQ1Y5RCP0igPkVGI1zux6A4wKWDML3Sfx0DtZofkxKf9nqfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] RE: RE: [PATCH v15] virtio-net: support device
 stats
Thread-Index: AQHZ0/q8Fy6v7smapEyK75bFcU4pP6/5UWQAgAdYuYCAADZqAIAACU0AgAA9H3A=
Date: Tue, 29 Aug 2023 10:58:40 +0000
Message-ID:
 <PH0PR12MB54811CB118D7D9BC36E563BCDCE7A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230821064258.20608-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54814174FC713CF5640B7B10DC1DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693279777.37882-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548154BAE90B3F4A24175060DCE7A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693293460.1621294-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1693293460.1621294-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB7797:EE_
x-ms-office365-filtering-correlation-id: bf6eca7d-4ff1-45c4-5f38-08dba87ee782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 46U8uYlgjYjroXO/wTcVPCNqD45t/cwKWSDxUHkqcLUzsefsnRCcfRlQGBJ31SLYmfV9uWQ4AAkTa9mPIt2Wubo9ODdBspGgqb4LZ+gVJX6Sw82YOX639m2D3ivQ9Oyx2p1GFf5bVFlhlkHDrVflnF6AIZiXGrBL7vHlln3x7HlKqWH2tbisP1kpVkruSJt6vbfvWndtahxJtujug4kSOGO8gt8n5/IrMY5iQUrzn1foVyVXun25j+qMxZ0qJV0ErsAZ8v7uLH40HLQj5QVVITIbYd+rNC5z298L2+Fxe5M88vzFplHOn1lqkhEpHeTP4dl0HmKuj6PiNESo3C5olh5b0hiKh+F6m+1U19kbAEqERLe86zgdef1yfG+HZpdU9+DrBBQOpZLDKILgLAANWtBXsKHgSrW9FgAaXR0DICHFTBqFge1D3jbPjRRR6C/i61DIXW4a0aMCS1fslpyX9QPhncjACkt/y2DpYljdzUe1TJ4X2FxQYVdKDA3pufzu+b3K5yDIwpHBzUg9HZhM93EWgCTj493Q4lgG4eQoC6oz8uIY5KCQXw2MJQfLWwid0K8qfSGBi4SmMahe7CWUWHTniuo2HEvzGcRdZS5JpfHsLjZ9CwOdn209nUOxCcI0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(186009)(1800799009)(451199024)(9686003)(7696005)(71200400001)(6506007)(478600001)(2906002)(26005)(4744005)(64756008)(316002)(6916009)(66446008)(66476007)(66556008)(52536014)(66946007)(54906003)(41300700001)(8936002)(5660300002)(4326008)(8676002)(76116006)(33656002)(55016003)(38070700005)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t2Fvry6/UvC+wuzJRudEBtbk1NpXzR/wX7sBIq7LRUBs02K8A1JmPFvUifEq?=
 =?us-ascii?Q?d/Q4CwK6F6vMZ53pCVhLu/4DK5IyT/zuIj0Dcr85I9QYU4tBh6ER6N0w0DGM?=
 =?us-ascii?Q?Wt5OTPxKTLzg/JBvW+h0RStcLIqMUDj0uOtcpfNad7NeIAIzLWD3i9PRQf1X?=
 =?us-ascii?Q?gSc5uGxuhLwQFfS+epug/wmuxC9c6as5+nufBVGg5BhA3kLMbRnlIONneY2n?=
 =?us-ascii?Q?iW5IU3L9bVRnc2b/BgELbhCXNAbHGP5jo5DueTT5Jh5MMR6zrVcStCwJ1oti?=
 =?us-ascii?Q?kCaJJVQr47CdSoCOkucv2He52x+dQXECL+EnYOQbVNyO1jCIofkb4L0QvqSk?=
 =?us-ascii?Q?7e/2NzeSQQBa2HJhuJa8yCRfFeVt00AzqaeEUuw0YOGx6FdhjeTRnFOh3vTc?=
 =?us-ascii?Q?6ymy/9v2tLevGG4x93Bq/hlcZ8bbXFULJzYezCl2pjaGxHbJaerNy7b/7SG5?=
 =?us-ascii?Q?EBkW55y2AqbLIyzHgQKunkhlZQYPYK49cQiri68udI6qCYo1St84EQ0qtcYD?=
 =?us-ascii?Q?2TTj7hwJmO3m/JxtryoGVem1z3ttEZXY1yTrI3jEQsPx57FtoV1v0rrIGeEP?=
 =?us-ascii?Q?nyqAKYzUk8PqFmyvlVVBHRLBVqakRravYH5+dSt7j2jtql/8CVkENVTvVbej?=
 =?us-ascii?Q?odggF9pC2m8C+mD2jTMWIIt4ndqu9MFNNclrkZ1f7L5GbHNddU//C/SJMJ2S?=
 =?us-ascii?Q?uR6SzAaMsEucQkNOlTQ4MOG89Tan6KvofC8mIgV/ij3jBg+q5KhAJr+6FcK9?=
 =?us-ascii?Q?Pl1NYWvvG5ZUElsJ+EjcdFE8wnhz3z4Q7sViVh29Wmi2juX6xRKWQEQ/PhfP?=
 =?us-ascii?Q?bsKcaNo9p70tNRBABUzsqnLZoMtI5bVsgWvkGkJ5lrHqf/Bzk4Elv7SgQ+bX?=
 =?us-ascii?Q?OfsTFjxKMmEzeadPqxABd9AoT7myg+r53j1D8tgwi15i2C2y/uQPGRImk10W?=
 =?us-ascii?Q?uD0vnW0jzTV+a3xiq+mK3sIox0FGu3RgFWJOfwCkPPtFt9OrtPi+QsYw5jjx?=
 =?us-ascii?Q?7ruztPH96HlEbhpm6oNGvozft3IQN26Loms5vWhzGNR2FOzALMw1qwyFOWDs?=
 =?us-ascii?Q?8TAjDTO49mmUHh56IGd19Ed80gmYqH0Pbc7HrsnoGg3JxNUadCZLcz7D4SXj?=
 =?us-ascii?Q?PO0Da2wEWs42OfaNn4eyzunkups4mrkQ/msOC+emc9T4sduYznbyj4JyeeFs?=
 =?us-ascii?Q?Fkssyxd4Zr8hAbHm0uXRIijmaX1NT68AlNlNR81YOyCh0vx+NdZw4VLR+vIp?=
 =?us-ascii?Q?RMh6PT4iqO3wTbwfQlwzTAQhMnxNCNIYXMqYYGzmjLMN/v+Fh3uLRDSaW0FS?=
 =?us-ascii?Q?5hpm2q8segwua4tUXujM3r/zT5BupUwW7y1dKuGL2ny22gHTR2ITN2mJCVYk?=
 =?us-ascii?Q?l3C42wsoP7EWm5l8kCCX4CHj0rIpEOhPY4mrct7YDMRb+Pqhc2GyhP18q+kz?=
 =?us-ascii?Q?gpMN+iZC58Lx3lFrtDZIaCn1r6C6sQZG8Y2Of/OpicxJ9RwPFbBUZoUfPXQ+?=
 =?us-ascii?Q?bRgsMqUxH1IwFhPq/79hmqeTGYlL64rjzQS6zcygzI47tLhGPHEkOcZoZsoI?=
 =?us-ascii?Q?hIgFQ6v3hvvdTLW4fyQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6eca7d-4ff1-45c4-5f38-08dba87ee782
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 10:58:40.6232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U42jK9uLlPLwM96OQ+5o5kwRzs/brbEBJ11frR66mY5a3jZ+Hsqt75mnSmDYACf1+fXE9TaQhPVfq5nfrCyzbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
Subject: [virtio-dev] RE: [virtio-comment] RE: RE: [PATCH v15] virtio-net: support device
 stats


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 29, 2023 12:48 PM
>=20
> For this line:
>  "If the reply header structure and actual stats are split properly, it w=
ill be easy
>   to add the query by the owner device."
>=20
> So for the header structure, is there some specific requirements?

TLV type, length, is only two fields needed and to align to 64-bit.
struct virtio_element_type {
	u16 type;
	u16 rsvd;
	u32 length;
};

Above generic type if defined, that we can possibly use across many virtio =
devices.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

